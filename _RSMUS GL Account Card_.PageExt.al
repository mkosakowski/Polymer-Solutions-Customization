pageextension 50112 "RSMUS GL Account Card" extends "G/L Account Card" //17
{
    actions
    {
        addafter("G/L Register")
        {
            action(RSMUSPush)
            {
                Caption = 'Push to Companies';
                ApplicationArea = All;
                Image = Company;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    GLAcc: Record "G/L Account";
                    lCompanies: Record Company;
                    lBlockedCompanies: Record "RSMUS Blocked Company GL";
                    lAccessibleCompanies: Page "RSMUS Accessible Companies";
                begin
                    lAccessibleCompanies.LOOKUPMODE:=true;
                    IF lAccessibleCompanies.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        lCompanies.Reset();
                        lCompanies.SetFilter(Name, '<>%1', CompanyName);
                        If lCompanies.FindSet()then repeat If GLAcc.ChangeCompany(lCompanies.Name)then If not GLAcc.get(rec."No.")then begin
                                        OtherCompanyGLAcc(GLAcc);
                                        If lBlockedCompanies.Get(lCompanies.Name)then GLAcc.Blocked:=true
                                        else
                                            GLAcc.Blocked:=false;
                                        GLAcc.Insert(true);
                                        //Consol. Translation Method seems to be updated OnInsert so resetting it here from the copied from company
                                        GLAcc.Validate("Consol. Translation Method", Rec."Consol. Translation Method");
                                        GLAcc.Modify();
                                    end
                                    else
                                    begin
                                        OtherCompanyGLAcc(GLAcc);
                                        If lBlockedCompanies.Get(lCompanies.Name)then GLAcc.Blocked:=true
                                        else
                                            GLAcc.Blocked:=false;
                                        GLAcc.Modify(true);
                                    end;
                                PushGLAcctDefaultDimensions(lCompanies.Name); //RSM10539
                            until lCompanies.Next() = 0;
                        Message('G/L Account processed to all other Companies');
                    end;
                end;
            }
        }
    }
    local procedure OtherCompanyGLAcc(var GLAcc: Record "G/L Account")
    begin
        GLAcc."No.":=rec."No.";
        GLAcc.Name:=rec.Name;
        GLAcc.Validate("Income/Balance", rec."Income/Balance");
        GLAcc.Validate("Account Category", rec."Account Category");
        GLAcc.Validate("Account Subcategory Entry No.", rec."Account Subcategory Entry No.");
        GLAcc.Validate("Debit/Credit", rec."Debit/Credit");
        GLAcc.Validate("Account Type", rec."Account Type");
        GLAcc.validate("Direct Posting", rec."Direct Posting");
    end;
    //RSM10539 >>
    local procedure PushGLAcctDefaultDimensions(NewCompanyName: Text[30])
    var
        LocalDefaultDimension: Record "Default Dimension";
        CompanyDefaultDimension: Record "Default Dimension";
    begin
        LocalDefaultDimension.Reset();
        LocalDefaultDimension.SetRange("Table ID", Database::"G/L Account");
        LocalDefaultDimension.SetRange("No.", Rec."No.");
        if LocalDefaultDimension.FindSet()then repeat //Loop all Local Default Dimensions to see if we should insert or update default dimension in new company
                if CompanyDefaultDimension.ChangeCompany(NewCompanyName)then begin
                    if not CompanyDefaultDimension.Get(Database::"G/L Account", Rec."No.", LocalDefaultDimension."Dimension Code")then begin
                        CompanyDefaultDimension.Init();
                        OtherCompanyDefaultDimension(CompanyDefaultDimension, LocalDefaultDimension);
                        CompanyDefaultDimension.Insert();
                    end
                    else
                    begin
                        OtherCompanyDefaultDimension(CompanyDefaultDimension, LocalDefaultDimension);
                        CompanyDefaultDimension.Modify();
                    end;
                end;
            until LocalDefaultDimension.Next() = 0;
    end;
    local procedure OtherCompanyDefaultDimension(var CompanyDefaultDimension: Record "Default Dimension"; LocalDefaultDimension: Record "Default Dimension")
    begin
        CompanyDefaultDimension.Validate("Table ID", LocalDefaultDimension."Table ID");
        CompanyDefaultDimension.Validate("No.", LocalDefaultDimension."No.");
        CompanyDefaultDimension.Validate("Dimension Code", LocalDefaultDimension."Dimension Code");
        CompanyDefaultDimension.Validate("Dimension Value Code", LocalDefaultDimension."Dimension Value Code");
        CompanyDefaultDimension.Validate("Value Posting", LocalDefaultDimension."Value Posting");
    end;
//RSM10539 <<
}

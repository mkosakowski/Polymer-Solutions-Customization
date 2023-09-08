page 50100 "RSMUS Accessible Companies"
{
    //RSM10243 BRK 08/22/2022 BRD-0029: Genesis of Dimension and Dimension Value company copy
    Caption = 'Allowed Companies';
    PageType = StandardDialog;
    SourceTable = Company;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(CompanyDisplayName; Rec."Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    ToolTip = 'Specifies the display name that is defined for the company. If a display name is not defined, then the company name is used.';
                    Editable = false;
                }
                field(RSMUSBlocked; RSMUSBlocked)
                {
                    ApplicationArea = All;
                    Caption = 'Blocked';
                    ToolTip = 'Specifies whether or not the GL being pushed renders a blocked result';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        If not RSMUSBlockedCompany.Get(rec.Name) and RSMUSBlocked then begin
                            RSMUSBlockedCompany.Init();
                            RSMUSBlockedCompany.Company:=rec.Name;
                            RSMUSBlockedCompany.Blocked:=RSMUSBlocked;
                            RSMUSBlockedCompany.Insert();
                        end
                        else If RSMUSBlockedCompany.Get(rec.Name) and not RSMUSBlocked then begin
                                RSMUSBlockedCompany.Delete();
                            end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Clear(RSMUSBlocked);
        RSMUSBlockedCompany.Reset();
        If RSMUSBlockedCompany.Get(rec.Name)then RSMUSBlocked:=RSMUSBlockedCompany.Blocked;
    end;
    trigger OnOpenPage()
    begin
        //Hide my current company since the use case for the page is to select Blocked status during Master data copy
        Rec.SetFilter(Name, '<>%1', CompanyName());
    end;
    var RSMUSBlockedCompany: Record "RSMUS Blocked Company GL";
    RSMUSBlocked: Boolean;
}

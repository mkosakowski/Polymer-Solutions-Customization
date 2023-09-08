page 50101 "RSMUSAccessibleCompaniesDim"
{
    //RSM10243 BRK 08/22/2022 BRD-0029: Genesis of Dimension and Dimension Value company copy
    Caption = 'Allowed Companies Dimension';
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
                    ToolTip = 'Specifies whether or not the Dimension being pushed renders a blocked result';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        //Update log table to maintain selected state
                        If not RSMUSBlockedCompany.Get(Rec.Name) and RSMUSBlocked then begin
                            RSMUSBlockedCompany.Init();
                            RSMUSBlockedCompany.Company:=Rec.Name;
                            RSMUSBlockedCompany.Blocked:=RSMUSBlocked;
                            RSMUSBlockedCompany.Insert();
                        end
                        else If RSMUSBlockedCompany.Get(Rec.Name) and not RSMUSBlocked then begin
                                RSMUSBlockedCompany.Delete();
                            end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        //Set original status
        Clear(RSMUSBlocked);
        RSMUSBlockedCompany.Reset();
        If RSMUSBlockedCompany.Get(Rec.Name)then RSMUSBlocked:=RSMUSBlockedCompany.Blocked;
    end;
    trigger OnOpenPage()
    begin
        //Hide my current company since the use case for the page is to select Blocked status during Master data copy
        Rec.SetFilter(Name, '<>%1', CompanyName());
    end;
    var RSMUSBlockedCompany: Record RSMUSBlockedDimension;
    RSMUSBlocked: Boolean;
}

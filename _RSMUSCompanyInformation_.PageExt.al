pageextension 50142 "RSMUSCompanyInformation" extends "Company Information" //1
{
    layout
    {
        addafter(Shipping)
        {
            group(RSMUSPackingSlip)
            {
                Caption = 'Packing Slip';

                field(RSMUSEmergencyWithinUS; Rec.RSMUSEmergencyWithinUS)
                {
                    ApplicationArea = All;
                }
                field(RSMUSEmergencyOutsideUS; Rec.RSMUSEmergencyOutsideUS)
                {
                    ApplicationArea = All;
                }
                field(RSMUSAuthorizationForReturn; AuthorizationText)
                {
                    ApplicationArea = All;
                    Caption = 'Authorization for Return';
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.SetAuthorizationText(AuthorizationText);
                    end;
                }
                field(RSMUSShippingCertification; Rec.RSMUSShippingCertification)
                {
                    ApplicationArea = All;
                }
                field(RSMUSRevisionNo; Rec.RSMUSRevisionNo)
                {
                    ApplicationArea = All;
                }
                field(RSMUSPackingSlipFooter; Rec.RSMUSPackingSlipFooter)
                {
                    ApplicationArea = All;
                }
                field(RSMUSEmergencyResponse; Rec.RSMUSEmergencyResponse)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        AuthorizationText:=Rec.GetAuthorizationText();
    end;
    var AuthorizationText: Text;
}

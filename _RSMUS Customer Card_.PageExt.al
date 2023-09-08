pageextension 50126 "RSMUS Customer Card" extends "Customer Card" //21
{
    layout
    {
        addlast(General)
        {
            field("RSMUS NIF No."; Rec."RSMUS NIF No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Tax Exemption No.")
        {
            //RSM11081 >>
            field(RSMUSTaxExemptionStatus; Rec.RSMUSTaxExemptionStatus)
            {
                ApplicationArea = All;
            }
            field(RSMUSTaxExemptionNumber; Rec.RSMUSTaxExemptionNumber)
            {
                ApplicationArea = All;
            }
        //RSM11081 <<
        }
        //RSM11081 >>
        modify("Tax Liable")
        {
            Caption = 'Avalara Tax Liable';
        }
        modify("Tax Exemption No.")
        {
            Caption = 'Avalara Tax Exemption No.';
        }
    }
    actions
    {
        addlast("&Customer")
        {
            action(RSMUSInvoiceRouting)
            {
                ApplicationArea = All;
                Caption = 'Invoice Routing';
                ToolTip = 'Lookup to the Invoice Routing Master Record for the following Customer';
                Image = OpenWorksheet;
                Promoted = true;
                PromotedCategory = Category9;
                RunObject = page "RSMUS DDMS Master";
                RunPageLink = "Customer No."=field("No.");
                RunPageMode = Edit;
            }
        }
    }
}

page 50105 "RSMUS DDMS Documents"
{
    //RSM10331 MGZ 09/28/22 BRD-0004: Genesis - Create DDMS Documents page for Foreign Trade
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Caption = 'Invoice Routing Documents';
    PageType = List;
    SourceTable = "RSMUS DDMS Documents";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Sent Via Email"; Rec."Sent Via Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sent Via Email field.';
                }
                field("Recipient Email"; Rec."Recipient Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recipient Email field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty of documents to be Couriered field.';
                }
                field("Couriered to Freight Forwarder"; Rec."Couriered to Freight Forwarder")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Couriered to Freight Forwarder field.';
                }
                field("Freight Forwarder Type"; Rec."Freight Forwarder Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Freight Forwarder Type field.';
                }
                field("Forward to Name"; Rec."Forward to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Forward to Name field.';
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recipient Name field.';
                }
            }
        }
    }
}

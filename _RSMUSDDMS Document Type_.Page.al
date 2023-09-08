page 50103 "RSMUSDDMS Document Type"
{
    //RSM10331 MGZ 09/13/22 BRD-0004: Genesis - Create DDMS Document Type page for related table
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    ApplicationArea = All;
    Caption = 'Invoice Routing Document Type';
    PageType = List;
    SourceTable = "RSMUS DDMS Document Type";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Document Type Name"; Rec."Document Type Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type Name field.';
                }
            }
        }
    }
}

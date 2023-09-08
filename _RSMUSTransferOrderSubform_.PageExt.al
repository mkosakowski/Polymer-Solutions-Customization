pageextension 50106 "RSMUSTransferOrderSubform" extends "Transfer Order Subform" //5741
{
    layout
    {
        addafter("Item No.")
        {
            field("RSMUS Item Reference No."; Rec."RSMUS Item Reference No.")
            {
                ApplicationArea = All;
            }
            field(RSMUSPackaging; Rec."RSMUS Packaging")
            {
                Caption = 'Packaging';
                ApplicationArea = All;
            }
        }
    }
}

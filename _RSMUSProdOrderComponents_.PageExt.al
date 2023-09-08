pageextension 50151 "RSMUSProdOrderComponents" extends "Prod. Order Components" //99000818
{
    layout
    {
        addafter("Remaining Quantity")
        {
            field("RSMUSPick Qty."; Rec."Pick Qty.")
            {
                ApplicationArea = All;
            }
        }
    }
}

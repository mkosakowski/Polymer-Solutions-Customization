pageextension 50150 "RSMUSStockkeepingUnitList" extends "Stockkeeping Unit List" //5701
{
    layout
    {
        addbefore(Inventory)
        {
            field("RSMUSQty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
        }
    }
}

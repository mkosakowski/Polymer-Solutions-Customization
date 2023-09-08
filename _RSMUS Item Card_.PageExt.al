pageextension 50127 "RSMUS Item Card" extends "Item Card" //30
{
    layout
    {
        addlast(Item)
        {
            field("RSMUS Product Description"; Rec."RSMUS Product Description")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("RSMUS Shelf Life"; Rec."RSMUS Shelf Life")
            {
                ApplicationArea = All;
            }
        }
        addlast(InventoryGrp)
        {
            //RSM12920 >>
            field("RSMUSSAT Hazardous Material"; Rec."SAT Hazardous Material")
            {
                ApplicationArea = All;
            }
        //RSM12920 <<
        }
    }
    actions
    {
        addlast(Navigation_Item)
        {
            action(RSMUSRunEOQ)
            {
                ApplicationArea = All;
                Caption = 'EOQ';
                Image = Navigate;
                RunObject = Page RSMUSEOQMapping;
                RunPageLink = ItemNo=field("No.");
                ToolTip = 'View EOQ mapping for the item.';
            }
        }
    }
//RSM10333 <<
}

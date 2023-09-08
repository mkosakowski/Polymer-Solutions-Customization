pageextension 50121 "RSMUS Item Vendor Catalog" extends "Item Vendor Catalog" //114
{
    layout
    {
        addafter("Vendor Item No.")
        {
            field("RSMUS COA Required"; Rec."RSMUS COA Required")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast("&Item Vendor")
        {
            action(RSMUSRunEOQ)
            {
                ApplicationArea = All;
                Caption = 'EOQ';
                Image = Navigate;
                RunObject = Page RSMUSEOQMapping;
                RunPageLink = ItemNo=field("Item No."), VendorNo=field("Vendor No.");
                ToolTip = 'View EOQ mapping for the item and vendor.';
            }
        }
    }
//RSM10333 <<
}

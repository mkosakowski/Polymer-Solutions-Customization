pageextension 50136 "RSMUSVendorCard" extends "Vendor Card" //26
{
    actions
    {
        addlast("Ven&dor")
        {
            action(RSMUSRunEOQ)
            {
                ApplicationArea = All;
                Caption = 'EOQ';
                Image = Navigate;
                RunObject = Page RSMUSEOQMapping;
                RunPageLink = VendorNo=field("No.");
                ToolTip = 'View EOQ mapping for the vendor.';
            }
        }
    }
}

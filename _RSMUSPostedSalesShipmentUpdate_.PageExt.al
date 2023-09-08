pageextension 50146 "RSMUSPostedSalesShipmentUpdate" extends "Posted Sales Shipment - Update" //1350
{
    layout
    {
        addlast(General)
        {
            field(RSMUSPuller; Rec.RSMUSPuller)
            {
                ApplicationArea = All;
            }
            field(RSMUSPacker; Rec.RSMUSPacker)
            {
                ApplicationArea = All;
            }
            field(RSMUSLoader; Rec.RSMUSLoader)
            {
                ApplicationArea = All;
            }
        }
    }
}

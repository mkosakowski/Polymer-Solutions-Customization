pageextension 50143 "RSMUSWarehouseShipment" extends "Warehouse Shipment" //7335
{
    layout
    {
        addlast(General)
        {
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

tableextension 50141 "RSMUSWarehouseShipmentLine" extends "Warehouse Shipment Line" //7321
{
    fields
    {
        field(50100; RSMUSNetWeight; Decimal)
        {
            Caption = 'Net Weight';
        }
        field(50101; RSMUSGrossWeight; Decimal)
        {
            Caption = 'Gross Weight';
        }
    }
}

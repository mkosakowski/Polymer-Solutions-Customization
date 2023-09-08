tableextension 50140 "RSMUSWarehouseShipmentHeader" extends "Warehouse Shipment Header" //7320
{
    fields
    {
        field(50100; RSMUSPacker; Text[50])
        {
            Caption = 'Packer';
        }
        field(50101; RSMUSLoader; Text[50])
        {
            Caption = 'Loader';
        }
        field(50102; RSMUSNetWeightTotal; Decimal)
        {
            Caption = 'Net Weight Total';
            FieldClass = FlowField;
            CalcFormula = sum("Warehouse Shipment Line".RSMUSNetWeight where("No."=field("No.")));
        }
        field(50103; RSMUSGrossWeightTotal; Decimal)
        {
            Caption = 'Gross Weight Total';
            FieldClass = FlowField;
            CalcFormula = sum("Warehouse Shipment Line".RSMUSGrossWeight where("No."=field("No.")));
        }
    }
}

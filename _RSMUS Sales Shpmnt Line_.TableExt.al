tableextension 50102 "RSMUS Sales Shpmnt Line" extends "Sales Shipment Line" //111
{
    fields
    {
        // Add changes to table fields here
        field(50100; "RSMUS Packaging"; Text[10])
        {
            Caption = 'Packaging';
        }
        field(50101; RSMUSNetWeight; Decimal)
        {
            Caption = 'Net Weight';
        }
        field(50102; RSMUSGrossWeight; Decimal)
        {
            Caption = 'Gross Weight';
        }
        field(50103; RSMUSPackingSlipQuantity; Decimal)
        {
        }
    }
}

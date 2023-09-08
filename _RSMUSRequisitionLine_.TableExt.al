tableextension 50138 "RSMUSRequisitionLine" extends "Requisition Line" //246
{
    fields
    {
        field(50100; RSMUSEOQ; Decimal)
        {
            Caption = 'EOQ';
            FieldClass = FlowField;
            CalcFormula = lookup(RSMUSEOQMapping.EOQ where(ItemNo=field("No."), ItemUOM=field("Unit of Measure Code"), VendorNo=field("Vendor No."), LocationCode=field("Location Code")));
            BlankZero = true;
            DecimalPlaces = 0: 5;
            Editable = false;
        }
    }
}

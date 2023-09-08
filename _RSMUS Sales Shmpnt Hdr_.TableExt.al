tableextension 50129 "RSMUS Sales Shmpnt Hdr" extends "Sales Shipment Header" //110
{
    fields
    {
        field(50100; "RSMUS Final Destination"; Text[100])
        {
            Caption = 'Final Destination';
            DataClassification = ToBeClassified;
        }
        //RSM11084 >>
        //field(50101) RESERVED FOR A FLOWFIELD ON INVOICE
        field(50102; RSMUSCut; Date)
        {
            Caption = 'Cut';
        }
        field(50103; RSMUSBookingNo; Text[20])
        {
            Caption = 'Booking No.';
        }
        field(50104; RSMUSBookingETA; Date)
        {
            Caption = 'Booking ETA';
        }
        field(50105; RSMUSERD; Date)
        {
            Caption = 'ERD';
        }
        //RSM11084 <<
        //RSM11506 >>
        field(50106; RSMUSPacker; Text[50])
        {
            Caption = 'Packer';
        }
        field(50107; RSMUSLoader; Text[50])
        {
            Caption = 'Loader';
        }
        field(50108; RSMUSNetWeightTotal; Decimal)
        {
            Caption = 'Net Weight Total';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Shipment Line".RSMUSNetWeight where("Document No."=field("No.")));
        }
        field(50109; RSMUSGrossWeightTotal; Decimal)
        {
            Caption = 'Gross Weight Total';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Shipment Line".RSMUSGrossWeight where("Document No."=field("No.")));
        }
        field(50110; RSMUSPuller; Text[50])
        {
            Caption = 'Puller';
        }
        field(50111; RSMUSWarehouseShipmentDate; Date)
        {
            Caption = 'Warehouse Shipment Date';
        }
    }
}

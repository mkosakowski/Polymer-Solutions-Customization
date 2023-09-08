tableextension 50110 "RSMUS Transfer Shmnt Hdr" extends "Transfer Shipment Header" //5744
{
    fields
    {
        field(50100; "RSMUS Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(50101; "RSMUS Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            TableRelation = Customer;
        }
        field(50102; "RSMUS Packaging"; Text[10])
        {
            Caption = 'Packaging';
            TableRelation = "Transfer Header";
        }
    }
}

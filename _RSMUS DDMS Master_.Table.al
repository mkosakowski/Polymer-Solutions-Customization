table 50102 "RSMUS DDMS Master"
{
    //RSM10331 MGZ 09/13/22 BRD-0004: Genesis - Create DDMS Master table for Foreign Trade
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Caption = 'Invoice Routing Master';

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                lCustomer: Record Customer;
            begin
                If lCustomer.Get(rec."Customer No.")then rec."Customer Name":=lCustomer.Name;
            end;
        }
        field(10; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(11; CustomerCountry; Code[10])
        {
            Caption = 'Customer Country';
            TableRelation = "Country/Region";
        }
        field(12; CustomerShipmentMethod; Code[10])
        {
            Caption = 'Customer Shipment Method';
            TableRelation = "Shipment Method";
        }
        field(20; Notes; Text[1000])
        {
            Caption = 'Notes';
        }
        field(21; "Recipient Address"; Text[1000])
        {
            Caption = 'Recipient Address';
        }
    }
    keys
    {
        key(PK; "Customer No.")
        {
            Clustered = true;
        }
    }
}

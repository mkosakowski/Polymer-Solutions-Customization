enum 50102 "RSMUS Freight Forwarder Type"
{
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Extensible = true;
    Caption = 'Freight Forwarder Type';

    value(100; Customer)
    {
    Caption = 'Customer';
    }
    value(200; "Customer FF")
    {
    Caption = 'Customer FF';
    }
    value(300; "Bank")
    {
    Caption = 'Bank';
    }
}

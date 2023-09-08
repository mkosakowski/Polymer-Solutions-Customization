enum 50101 "RSMUS Couriered to Fght Frwrdr"
{
    //RSM10331 MGZ 09/16/22 BRD-0004: Genesis - Create DDMS Enum for field on RSMUS DDMS Documents Table
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Extensible = true;
    Caption = 'Couriered to Freight Forwarder';

    value(100; "PSG Freight forwarder")
    {
    Caption = 'PSG Freight forwarder';
    }
    value(200; "Customer Freight Forwarder")
    {
    Caption = 'Customer Freight Forwarder';
    }
    value(300; "Direct")
    {
    Caption = 'Direct';
    }
}

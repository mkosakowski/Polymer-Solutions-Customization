permissionset 50101 "RSMUSDDMSEdit"
{
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Assignable = true;
    Caption = 'DDMS-Edit';
    Permissions = tabledata "RSMUS DDMS Master"=RIMD,
        tabledata "RSMUS DDMS Document Type"=RIMD,
        tabledata "RSMUS DDMS Documents"=RIMD,
        tabledata "RSMUS DDMS Recipient Emails"=RIMD;
}

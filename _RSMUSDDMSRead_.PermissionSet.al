permissionset 50102 "RSMUSDDMSRead"
{
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Assignable = true;
    Caption = 'DDMS-Read';
    Permissions = tabledata "RSMUS DDMS Master"=R,
        tabledata "RSMUS DDMS Document Type"=R,
        tabledata "RSMUS DDMS Documents"=R,
        tabledata "RSMUS DDMS Recipient Emails"=R;
}

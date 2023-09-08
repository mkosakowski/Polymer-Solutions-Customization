permissionset 50100 "RSMUSPSGCust"
{
    //RSM10243 BRK 08/22/2022 BRD-0029: Genesis of Dimension and Dimension Value company copy
    //RSM10564 BJK 11/13/2022 BRD-0042: 7th Ave Transfer Process
    //RSM10333 BRK 12/15/22 BRD-0015: Add EOQ functionality
    Assignable = true;
    Caption = 'PSG Customization';
    Permissions = tabledata "RSMUS Blocked Company GL"=RIMD,
        tabledata RSMUSBlockedDimension=RIMD,
        tabledata "RSMUS DDMS Master"=RIMD,
        tabledata "RSMUS DDMS Document Type"=RIMD,
        tabledata "RSMUS DDMS Documents"=RIMD,
        tabledata "RSMUS DDMS Recipient Emails"=RIMD,
        tabledata RSMUSTempProdOrderComponent=RIMD,
        tabledata RSMUSEOQMapping=RIMD;
}

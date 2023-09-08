table 50103 "RSMUS DDMS Document Type"
{
    //RSM10331 MGZ 09/16/22 BRD-0004: Genesis - Create DDMS Enum for field on RSMUS DDMS Documents Table
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Caption = 'Invoice Routing Document Type';

    fields
    {
        field(1; "Document Type"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Document Type Name"; Text[50])
        {
            Caption = 'Document Type Name';
        }
    }
    keys
    {
        key(PK; "Document Type", "Document Type Name")
        {
            Clustered = true;
        }
    }
}

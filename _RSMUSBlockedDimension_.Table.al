table 50101 "RSMUSBlockedDimension"
{
    //RSM10243 BRK 08/23/2022 BRD-0029: Genesis of Dimension and Dimension Value company copy
    Caption = 'Blocked Company Dimension';

    fields
    {
        field(1; Company; Text[100])
        {
            Caption = 'Company';
        }
        field(2; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
    }
    keys
    {
        key(PK; Company)
        {
            Clustered = true;
        }
    }
}

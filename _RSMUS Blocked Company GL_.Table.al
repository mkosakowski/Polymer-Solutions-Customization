table 50100 "RSMUS Blocked Company GL"
{
    //9933
    //Purpose of this table is to replicate the Company table which cannot be extended, we needed to add a blocked field
    //to the G/L Account when importing to other companies on the company list page
    //so this table just acts as a place holder for the logic
    Caption = 'Blocked Company GL';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Company; Text[100])
        {
            Caption = 'Company';
            DataClassification = ToBeClassified;
        }
        field(2; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
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

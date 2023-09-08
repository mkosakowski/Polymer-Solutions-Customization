tableextension 50123 "RSMUS QM Quality Mgmt Setup" extends "RSMUS QM Quality Mgmt Setup" //60007
{
    fields
    {
        field(50100; "RSMUS PSG CoA Email"; Text[50])
        {
            Caption = 'PSG CoA Email';
            DataClassification = ToBeClassified;
        }
        field(50101; "RSMUS Revision"; Text[50])
        {
            Caption = 'Revision';
            DataClassification = ToBeClassified;
        }
        //RSM10332 >>
        field(50102; RSMUSReceivingCOAEmail; Text[50])
        {
            Caption = 'Receiving COA Email';
        }
        //RSM10332 <<
        field(50103; RSMUSDefaultBatchUOM; Code[10])
        {
            Caption = 'Default Batch UoM';
            TableRelation = "Unit of Measure".Code;
        }
        field(50104; RSMUSDefaultShippedBatchUOM; Code[10])
        {
            Caption = 'Default Batch Shipped UoM';
            TableRelation = "Unit of Measure".Code;
        }
    }
}

tableextension 50134 "RSMUSQMPostedQualityHeader" extends "RSMUS QM Posted Quality Line" //60011
{
    fields
    {
        field(50100; RSMUSCOALowerLimit; Code[100])
        {
            Caption = 'COA Lower Limit';
        }
        field(50101; RSMUSCOAUpperLimit; Code[100])
        {
            Caption = 'COA Upper Limit';
        }
        field(50102; RSMUSCOANominalValue; Code[100])
        {
            Caption = 'COA Nominal Value';
        }
    }
}

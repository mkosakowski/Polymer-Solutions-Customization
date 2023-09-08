tableextension 50133 "RSMUSQMItemQualityChar" extends "RSMUS QM Item Quality Char." //60001
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

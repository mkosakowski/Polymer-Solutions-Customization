pageextension 50131 "RSMUSQMItemQualityChar" extends "RSMUS QM Item Quality Char." //60001
{
    layout
    {
        addlast(Group)
        {
            field(RSMUSCOALowerLimit; Rec.RSMUSCOALowerLimit)
            {
                ApplicationArea = All;
            }
            field(RSMUSCOAUpperLimit; Rec.RSMUSCOAUpperLimit)
            {
                ApplicationArea = All;
            }
            field(RSMUSCOANominalValue; Rec.RSMUSCOANominalValue)
            {
                ApplicationArea = All;
            }
        }
    }
}

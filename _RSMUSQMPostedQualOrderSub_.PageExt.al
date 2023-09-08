pageextension 50132 "RSMUSQMPostedQualOrderSub" extends "RSMUS QM Posted Qual Order Sub" //60013
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

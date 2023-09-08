pageextension 50133 "RSMUSQMQualityOrderSubform" extends "RSMUS QM Quality Order Subform" //60010
{
    layout
    {
        addlast(Group)
        {
            field(RSMUSCOALowerLimit; Rec.RSMUSCOALowerLimit)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RSMUSCOAUpperLimit; Rec.RSMUSCOAUpperLimit)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RSMUSCOANominalValue; Rec.RSMUSCOANominalValue)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}

pageextension 50148 "RSMUSManufacturingSetup" extends "Manufacturing Setup" //99000768
{
    layout
    {
        addlast(General)
        {
            field(RSMUSStackingReminder; Rec.RSMUSStackingReminder)
            {
                ApplicationArea = All;
            }
        }
    }
}

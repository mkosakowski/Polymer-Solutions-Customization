pageextension 50145 "RSMUSLocationCard" extends "Location Card" //5703
{
    layout
    {
        addlast(ContactDetails)
        {
            field(RSMUSReceivingHours; Rec.RSMUSReceivingHours)
            {
                ApplicationArea = All;
            }
        }
    }
}

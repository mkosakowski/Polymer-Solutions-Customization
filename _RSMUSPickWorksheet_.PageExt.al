pageextension 50149 "RSMUSPickWorksheet" extends "Pick Worksheet" //7345
{
    layout
    {
        addlast(Control1)
        {
            field("RSMUSFrom Bin Code"; Rec."From Bin Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

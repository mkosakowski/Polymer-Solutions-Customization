pageextension 50147 "RSMUSPostedItemTrackingLines" extends "Posted Item Tracking Lines" //6511
{
    layout
    {
        addafter(Quantity)
        {
            field("RSMUSUnit of Measure Code"; Rec."Unit of Measure Code")
            {
                ApplicationArea = All;
            }
            field("RSMUSQty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
            }
        }
    }
}

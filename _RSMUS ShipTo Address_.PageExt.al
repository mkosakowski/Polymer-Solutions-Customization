pageextension 50118 "RSMUS ShipTo Address" extends "Ship-to Address" //300
{
    layout
    {
        addlast(General)
        {
            field("RSMUS Final Destination"; Rec."RSMUS Final Destination")
            {
                ApplicationArea = All;
            }
        }
    }
}

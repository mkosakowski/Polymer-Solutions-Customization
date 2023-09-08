pageextension 50114 "RSMUS Purch Order List" extends "Purchase Order List" //9307
{
    layout
    {
        addlast(Control1)
        {
            field("RSMUS Confirmation Status"; Rec."RSMUS Confirmation Status")
            {
                ApplicationArea = All;
            }
        }
    }
}

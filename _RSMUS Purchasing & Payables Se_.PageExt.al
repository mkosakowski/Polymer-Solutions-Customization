pageextension 50119 "RSMUS Purchasing & Payables Se" extends "Purchases & Payables Setup" //460
{
    layout
    {
        addlast(General)
        {
            field("RSMUS Purchasing Email"; rec."RSMUS Purchasing Email")
            {
                ApplicationArea = All;
            }
        }
    }
}

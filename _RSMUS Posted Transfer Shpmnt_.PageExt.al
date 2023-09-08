pageextension 50110 "RSMUS Posted Transfer Shpmnt" extends "Posted Transfer Shipment" //5743
{
    layout
    {
        addlast(General)
        {
            field("RSMUSExternal Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
            field("RSMUS Customer No."; Rec."RSMUS Customer No.")
            {
                ApplicationArea = All;
            }
            field("RSMUS Customer Name"; Rec."RSMUS Customer Name")
            {
                ApplicationArea = All;
            }
        }
    }
}

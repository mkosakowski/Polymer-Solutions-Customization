pageextension 50111 "RSMUS Posted Transfer Rcpt" extends "Posted Transfer Receipt" //5745
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

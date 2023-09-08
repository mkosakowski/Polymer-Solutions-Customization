pageextension 50129 "RSMUS Item Ref List" extends "Item Reference List" //5735
{
    layout
    {
        addlast(Control1)
        {
            field("RSMUS Specification Date"; Rec."RSMUS Specification Date")
            {
                ApplicationArea = All;
            }
        }
    }
}

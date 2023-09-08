pageextension 50123 "RSMUS Purch. Comment Sheet" extends "Purch. Comment Sheet" //66
{
    layout
    {
        addafter(Comment)
        {
            field("RSMUS Print Comment"; Rec."RSMUS Print Comment")
            {
                Caption = 'Print on PO';
                ApplicationArea = all;
            }
        }
    }
}

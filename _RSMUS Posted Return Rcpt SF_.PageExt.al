pageextension 50104 "RSMUS Posted Return Rcpt SF" extends "Posted Return Receipt Subform" //6661
{
    layout
    {
        addlast(Control1)
        {
            field(RSMUSPackaging; Rec."RSMUS Packaging")
            {
                Caption = 'Packaging';
                ApplicationArea = All;
            }
        }
    }
}

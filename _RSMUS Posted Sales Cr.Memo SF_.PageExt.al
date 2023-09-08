pageextension 50105 "RSMUS Posted Sales Cr.Memo SF" extends "Posted Sales Cr. Memo Subform" //135
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

pageextension 50102 "RSMUS Posted Sales Inv SF" extends "Posted Sales Invoice Subform" //133
{
    layout
    {
        // Add changes to page layout here
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

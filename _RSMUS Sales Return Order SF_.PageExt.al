pageextension 50103 "RSMUS Sales Return Order SF" extends "Sales Return Order Subform" //6631
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

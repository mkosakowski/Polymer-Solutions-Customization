pageextension 50100 "RSMUSSalesOrderSubform" extends "Sales Order Subform" //46
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

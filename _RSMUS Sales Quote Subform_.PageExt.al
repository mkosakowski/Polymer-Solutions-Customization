pageextension 50117 "RSMUS Sales Quote Subform" extends "Sales Quote Subform" //95
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

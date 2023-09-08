pageextension 50108 "RSMUSPosted Transfer Rcpt SF" extends "Posted Transfer Rcpt. Subform" //5746
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

pageextension 50107 "RSMUS Posted Transfer Shmpt SF" extends "Posted Transfer Shpt. Subform" //5744
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

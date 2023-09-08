pageextension 50140 "RSMUSSalesOrderArchive" extends "Sales Order Archive" //5159
{
    layout
    {
        //RSM11084 >>
        addlast(General)
        {
            field(RSMUSCut; Rec.RSMUSCut)
            {
                ApplicationArea = All;
            }
            field(RSMUSBookingNo; Rec.RSMUSBookingNo)
            {
                ApplicationArea = All;
            }
            field(RSMUSBookingETA; Rec.RSMUSBookingETA)
            {
                ApplicationArea = All;
            }
            field(RSMUSERD; Rec.RSMUSERD)
            {
                ApplicationArea = All;
            }
        }
    }
}

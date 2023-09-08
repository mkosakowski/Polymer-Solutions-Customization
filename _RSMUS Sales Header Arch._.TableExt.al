tableextension 50130 "RSMUS Sales Header Arch." extends "Sales Header Archive" //5107
{
    fields
    {
        field(50100; "RSMUS Final Destination"; Text[100])
        {
            Caption = 'Final Destination';
            DataClassification = ToBeClassified;
        }
        //RSM11084 >>
        //field(50101) RESERVED FOR A FLOWFIELD ON INVOICE
        field(50102; RSMUSCut; Date)
        {
            Caption = 'Cut';
        }
        field(50103; RSMUSBookingNo; Text[20])
        {
            Caption = 'Booking No.';
        }
        field(50104; RSMUSBookingETA; Date)
        {
            Caption = 'Booking ETA';
        }
        field(50105; RSMUSERD; Date)
        {
            Caption = 'ERD';
        }
    }
}

tableextension 50126 "RSMUS Sales Header" extends "Sales Header" //36
{
    fields
    {
        field(50100; "RSMUS Final Destination"; Text[50])
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
        //RSM11084 <<
        modify("Ship-to Code")
        {
        trigger OnAfterValidate()
        var
            lShipTo: Record "Ship-to Address";
        begin
            If lShipTo.Get(rec."Sell-to Customer No.", rec."Ship-to Code")then rec."RSMUS Final Destination":=lShipTo."RSMUS Final Destination";
        end;
        }
    }
}

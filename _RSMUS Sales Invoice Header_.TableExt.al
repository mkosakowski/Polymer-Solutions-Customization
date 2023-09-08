tableextension 50128 "RSMUS Sales Invoice Header" extends "Sales Invoice Header" //112
{
    fields
    {
        field(50100; "RSMUS Final Destination"; Text[100])
        {
            Caption = 'Final Destination';
            DataClassification = ToBeClassified;
        }
        //RSM9939 >>
        field(50101; RSMUSShippingAgentServiceCode; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code"=FIELD("Shipping Agent Code"));
        }
        //RSM9939 <<
        //RSM11084 >>
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

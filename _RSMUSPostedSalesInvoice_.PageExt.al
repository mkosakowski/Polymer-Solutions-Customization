pageextension 50135 "RSMUSPostedSalesInvoice" extends "Posted Sales Invoice" //132
{
    layout
    {
        //RSM11084 >>
        addlast(General)
        {
            field(RSMUSCut; Rec.RSMUSCut)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RSMUSBookingNo; Rec.RSMUSBookingNo)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RSMUSBookingETA; Rec.RSMUSBookingETA)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RSMUSERD; Rec.RSMUSERD)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        //RSM11084 <<
        addafter("Shipping Agent Code")
        {
            field(RSMUSShippingAgentServiceCode; Rec.RSMUSShippingAgentServiceCode)
            {
                ApplicationArea = All;
            }
        }
    }
}

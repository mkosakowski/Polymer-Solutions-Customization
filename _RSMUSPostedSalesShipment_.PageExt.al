pageextension 50139 "RSMUSPostedSalesShipment" extends "Posted Sales Shipment" //130
{
    layout
    {
        addlast(General)
        {
            //RSM11084 >>
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
            //RSM11084 <<
            //RSM11506 >>
            field(RSMUSPuller; Rec.RSMUSPuller)
            {
                ApplicationArea = All;
            }
            field(RSMUSPacker; Rec.RSMUSPacker)
            {
                ApplicationArea = All;
            }
            field(RSMUSLoader; Rec.RSMUSLoader)
            {
                ApplicationArea = All;
            }
        //RSM11506 <<
        }
    }
}

pageextension 50128 "RSMUS QM Setup" extends "RSMUS QM Quality Mgmt Setup" //60007
{
    layout
    {
        addlast(General)
        {
            field("RSMUS PSG CoA Email"; Rec."RSMUS PSG CoA Email")
            {
                ApplicationArea = All;
            }
            field("RSMUS Revision"; Rec."RSMUS Revision")
            {
                ApplicationArea = All;
            }
            //RSM10332 >>
            field(RSMUSReceivingCOAEmail; Rec.RSMUSReceivingCOAEmail)
            {
                ApplicationArea = All;
            }
            //RSM10332 <<
            field(RSMUSDefaultBatchUOM; Rec.RSMUSDefaultBatchUOM)
            {
                ApplicationArea = All;
            }
            field(RSMUSDefaultShippedBatchUOM; Rec.RSMUSDefaultShippedBatchUOM)
            {
                ApplicationArea = All;
            }
        }
    }
}

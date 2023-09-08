pageextension 50137 "RSMUSReqWorksheet" extends "Req. Worksheet" //291
{
    layout
    {
        addlast(Control1)
        {
            field(RSMUSEOQ; RSMUSHelperFunctions.GetEOQ(Rec))
            {
                ApplicationArea = All;
                Caption = 'EOQ';
                BlankZero = true;
            }
        }
    }
    var RSMUSHelperFunctions: Codeunit RSMUSHelperFunctions;
}

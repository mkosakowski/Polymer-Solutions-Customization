pageextension 50122 "RSMUSPlanningWorksheet" extends "Planning Worksheet" //99000852
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

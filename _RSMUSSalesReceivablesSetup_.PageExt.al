pageextension 50134 "RSMUSSalesReceivablesSetup" extends "Sales & Receivables Setup" //459
{
    layout
    {
        addlast(General)
        {
            field(RSMUSRemitToName; Rec.RSMUSRemitToName)
            {
                ApplicationArea = All;
            }
            field(RSMUSRemitToAddress; Rec.RSMUSRemitToAddress)
            {
                ApplicationArea = All;
            }
            field(RSMUSRemitToAddress2; Rec.RSMUSRemitToAddress2)
            {
                ApplicationArea = All;
            }
            field(RSMUSRemitToCity; Rec.RSMUSRemitToCity)
            {
                ApplicationArea = All;
            }
            field(RSMUSRemitToState; Rec.RSMUSRemitToState)
            {
                ApplicationArea = All;
            }
            field(RSMUSRemitToZIPCode; Rec.RSMUSRemitToZIPCode)
            {
                ApplicationArea = All;
            }
        }
    }
}

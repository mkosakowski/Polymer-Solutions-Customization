pageextension 50138 "RSMUSCustomerList" extends "Customer List" //22
{
    layout
    {
        addlast(Control1)
        {
            field(RSMUSTaxExemptionStatus; Rec.RSMUSTaxExemptionStatus)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(RSMUSTaxExemptionNumber; Rec.RSMUSTaxExemptionNumber)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}

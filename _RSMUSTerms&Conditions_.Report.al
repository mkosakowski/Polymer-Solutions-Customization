report 50100 "RSMUSTerms&Conditions"
{
    RDLCLayout = './src/Report/Layouts/Rep50100.RSMUSTerms&Conditions.rdl';
    Caption = 'Terms and Conditions';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No_; "No.")
            {
            }
        }
    }
}

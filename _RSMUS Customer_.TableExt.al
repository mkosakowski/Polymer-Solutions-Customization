tableextension 50121 "RSMUS Customer" extends Customer //18
{
    fields
    {
        field(50100; "RSMUS NIF No."; Text[35])
        {
            Caption = 'NIF No.';
        }
        //RSM11081 >>
        field(50101; RSMUSTaxExemptionStatus; Boolean)
        {
            Caption = 'Tax Exemption Status';
        }
        field(50102; RSMUSTaxExemptionNumber; Text[50])
        {
            Caption = 'Tax Exemption Number';
        }
    }
}

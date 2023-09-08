tableextension 50137 "RSMUSSalesReceivablesSetup" extends "Sales & Receivables Setup" //311
{
    fields
    {
        field(50100; RSMUSRemitToName; Text[100])
        {
            Caption = 'Remit To Name';
        }
        field(50102; RSMUSRemitToAddress; Text[100])
        {
            Caption = 'Remit To Address';
        }
        field(50103; RSMUSRemitToAddress2; Text[50])
        {
            Caption = 'Remit To Address 2';
        }
        field(50104; RSMUSRemitToCity; Text[30])
        {
            Caption = 'Remit To City';
        }
        field(50105; RSMUSRemitToState; Text[30])
        {
            Caption = 'Remit To State';
        }
        field(50106; RSMUSRemitToZIPCode; Code[20])
        {
            Caption = 'Remit To ZIP Code';
        }
        field(50107; RSMUSRemitToCountry; Code[10])
        {
            TableRelation = "Country/Region".Code;
            Caption = 'Remit To Country';
        }
    }
}

tableextension 50111 "RSMUS Transfer Rcpt Hdr" extends "Transfer Receipt Header" //5746
{
    fields
    {
        field(50100; "RSMUS Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                lCust: Record Customer;
            begin
                If lCust.Get("RSMUS Customer No.")then begin
                    rec."RSMUS Customer Name":=lCust.Name;
                    rec.Modify(false);
                end end;
        }
        field(50101; "RSMUS Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            TableRelation = Customer;
        }
        field(50102; "RSMUS Packaging"; Text[10])
        {
            Caption = 'Packaging';
        }
    }
}

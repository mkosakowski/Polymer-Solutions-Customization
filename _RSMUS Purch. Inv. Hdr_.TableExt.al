tableextension 50114 "RSMUS Purch. Inv. Hdr" extends "Purch. Inv. Header" //122
{
    fields
    {
        field(50100; "RSMUS Confirmation Status";Enum "RSMUS Confirmation Status")
        {
            Caption = 'Confirmation Status';
        }
        field(50110; "RSMUS Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services"=R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(50111; "RSMUS Ship Agent Account No."; Text[30])
        {
            AccessByPermission = TableData "Shipping Agent Services"=R;
            Caption = 'Shipping Agent Account No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Shipping Agent"."Account No." where(Code=field("RSMUS Shipping Agent Code")));
        }
        field(50120; "RSMUS Pickup No."; Text[50])
        {
            Caption = 'Pickup No.';
        }
        field(50130; "RSMUS COA Required"; Boolean)
        {
            Caption = 'Certificate of Analysis Required';
        }
    }
}

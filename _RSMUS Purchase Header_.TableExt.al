tableextension 50112 "RSMUS Purchase Header" extends "Purchase Header" //38
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
            Caption = 'Pick Up No.';
        }
        field(50130; "RSMUS COA Required"; Boolean)
        {
            Caption = 'Certificate of Analysis Required';
        }
        field(50141; RSMUSHasDropShipLine; Boolean)
        {
            //RSM14788
            Caption = 'Drop Ship Lines';
            FieldClass = FlowField;
            CalcFormula = exist("Purchase Line" where("Document Type"=const(Order), "Document No."=field("No."), "Drop Shipment"=const(true)));
        }
    }
    procedure OnAfterInsertPurchOrderHeader_ReqWkshMakeOrder(RequisitionLine: Record "Requisition Line")
    var
        SalesHdr: record "Sales Header";
    begin
        //RSM14788 >>
        SalesHdr.SetLoadFields("Document Type", "External Document No.", "Shipping Agent Code");
        if not SalesHdr.get(SalesHdr."Document Type"::Order, RequisitionLine."Sales Order No.")then exit;
        Rec.Validate("Your Reference", SalesHdr."External Document No.");
        Rec.Validate("RSMUS Shipping Agent Code", SalesHdr."Shipping Agent Code");
    //RSM14788 <<
    end;
}

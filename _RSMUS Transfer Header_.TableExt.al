tableextension 50109 "RSMUS Transfer Header" extends "Transfer Header" //5740
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
                TransferLine: Record "Transfer Line";
                ItemReference: Record "Item Reference";
                Item: Record Item;
            begin
                If lCust.Get("RSMUS Customer No.")then begin
                    rec."RSMUS Customer Name":=lCust.Name;
                    Rec.Validate("Shipment Method Code", lCust."Shipment Method Code");
                    Rec.Validate("Shipping Agent Code", lCust."Shipping Agent Code");
                    Rec.Validate("Shipping Agent Service Code", lCust."Shipping Agent Service Code");
                    TransferLine.SetRange("Document No.", Rec."No.");
                    if TransferLine.FindSet()then repeat Clear(ItemReference);
                            ItemReference.SetRange("Item No.", TransferLine."Item No.");
                            ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::Customer);
                            ItemReference.SetRange("Reference Type No.", lCust."No.");
                            if ItemReference.FindFirst()then begin
                                TransferLine."RSMUS Item Reference No.":=ItemReference."Reference No.";
                                TransferLine.Description:=ItemReference.Description;
                                TransferLine.Modify();
                            end
                            else
                            begin
                                TransferLine."RSMUS Item Reference No.":='';
                                if Item.Get(TransferLine."Item No.")then TransferLine.Description:=Item.Description;
                                TransferLine.Modify();
                            end;
                        until TransferLine.Next() = 0;
                    rec.Modify(false);
                end end;
        }
        field(50101; "RSMUS Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            TableRelation = Customer;
            Editable = false;
        }
        field(50102; "RSMUS Packaging"; Text[10])
        {
            Caption = 'Packaging';
            TableRelation = "Transfer Shipment Header";
        }
    }
}

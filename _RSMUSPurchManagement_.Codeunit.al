codeunit 50104 "RSMUSPurchManagement"
{
    //RSM10332 BJK 10/31/2022 BRD-0009: Purchase Order Report
    procedure SetCOARequired(PurchLine: Record "Purchase Line")
    var
        PurchaseHeader: Record "Purchase Header";
        ItemVendor: Record "Item Vendor";
    begin
        if NOT PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchLine."Document No.")then exit;
        if ItemVendor.Get(PurchaseHeader."Buy-from Vendor No.", PurchLine."No.", PurchLine."Variant Code")then begin
            if(ItemVendor."RSMUS COA Required") AND (NOT PurchaseHeader."RSMUS COA Required")then begin
                PurchaseHeader.Validate("RSMUS COA Required", true);
                PurchaseHeader.Modify();
            end;
        end;
    end;
    procedure CheckCOARequired(var Rec: Record "Purchase Line")
    var
        lVendItemCatalog: Record "Item Vendor";
        lPurchHeader: Record "Purchase Header";
        lPurchLine: Record "Purchase Line";
        FoundCOARequiredBool: Boolean;
    begin
        FoundCOARequiredBool:=false;
        lPurchLine.SetRange("Document No.", rec."Document No.");
        If lPurchLine.FindSet()then repeat if lPurchLine.Type = lPurchLine.Type::Item then begin
                    lVendItemCatalog.SetFilter("Vendor No.", lPurchLine."Buy-from Vendor No.");
                    lVendItemCatalog.SetFilter("Item No.", lPurchLine."No.");
                    lVendItemCatalog.SetFilter("Variant Code", lPurchLine."Variant Code");
                    lVendItemCatalog.SetFilter("RSMUS COA Required", 'True');
                    If not lVendItemCatalog.IsEmpty()then begin
                        FoundCOARequiredBool:=true;
                        break;
                    end;
                end;
            until lPurchLine.Next() = 0;
        If(lPurchHeader.Get(rec."Document Type", rec."Document No.")) AND (Not FoundCOARequiredBool)then If lPurchHeader."RSMUS COA Required" = true then begin
                lPurchHeader."RSMUS COA Required":=false;
                lPurchHeader.Modify(false);
            end;
    end;
}

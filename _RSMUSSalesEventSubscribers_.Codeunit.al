codeunit 50106 "RSMUSSalesEventSubscribers"
{
    //RSM9939 BJK 12/01/2022 BRD-0036: Sales Invoice Report
    //RSM11194 BJK 02/02/23 BRD-0027: Packing Slip
    //RSM11506 BJK 2023-02-23 BRD-0024: Posted Sales Shipment Packing Slip
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeFinalizePosting', '', false, false)]
    local procedure SalesPost_OnRunOnBeforeFinalizePosting(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var EverythingInvoiced: Boolean; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10]; GenJnlLineDocNo: Code[20]; CommitIsSuppressed: Boolean)
    begin
        SalesInvoiceHeader.Validate("Shipping Agent Code", SalesHeader."Shipping Agent Code");
        SalesInvoiceHeader.Validate(RSMUSShippingAgentServiceCode, SalesHeader."Shipping Agent Service Code");
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Header", 'OnBeforeInsertEvent', '', false, false)]
    local procedure SalesInvoiceHeader_OnBeforeInsertEvent(var Rec: Record "Sales Invoice Header"; RunTrigger: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get(SalesHeader."Document Type"::Invoice, Rec."Pre-Assigned No.")then begin
            Rec.Validate("Shipping Agent Code", SalesHeader."Shipping Agent Code");
            Rec.Validate(RSMUSShippingAgentServiceCode, SalesHeader."Shipping Agent Service Code");
        end
        else if SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Order No.")then begin
                Rec.Validate("Shipping Agent Code", SalesHeader."Shipping Agent Code");
                Rec.Validate(RSMUSShippingAgentServiceCode, SalesHeader."Shipping Agent Service Code");
            end;
    end;
    //RSM11194 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", 'OnBeforeWhseShptLineModify', '', false, false)]
    local procedure WhseActivityRegister_OnBeforeWhseShptLineModify(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseActivityLine: Record "Warehouse Activity Line"; WhseActivityLineGrouped: Record "Warehouse Activity Line")
    var
        Item: Record Item;
    begin
        if Item.Get(WarehouseShipmentLine."Item No.")then begin
            WarehouseShipmentLine.Validate(RSMUSNetWeight, Item."Net Weight" * WarehouseShipmentLine."Qty. to Ship (Base)");
            WarehouseShipmentLine.Validate(RSMUSGrossWeight, Item."Gross Weight" * WarehouseShipmentLine."Qty. to Ship (Base)");
        end;
    end;
    //RSM11194 <<
    //RSM11506 >>
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnAfterInitFromSalesLine', '', false, false)]
    local procedure SalesShipmentLine_OnAfterInitFromSalesLine(SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    var
        Item: Record Item;
    begin
        SalesShptLine.Validate(RSMUSPackingSlipQuantity, SalesLine.Quantity);
        if(SalesShptLine.Type = SalesShptLine.Type::Item) AND (Item.Get(SalesShptLine."No."))then begin
            SalesShptLine.Validate(RSMUSNetWeight, SalesShptLine."Quantity (Base)" * Item."Net Weight");
            SalesShptLine.Validate(RSMUSGrossWeight, SalesShptLine."Quantity (Base)" * Item."Gross Weight");
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", 'OnAfterRecordChanged', '', false, false)]
    local procedure PostedSalesShipmentUpdate_OnAfterRecordChanged(var SalesShipmentHeader: Record "Sales Shipment Header"; xSalesShipmentHeader: Record "Sales Shipment Header"; var IsChanged: Boolean)
    begin
        if(SalesShipmentHeader.RSMUSPuller <> xSalesShipmentHeader.RSMUSPuller) or (SalesShipmentHeader.RSMUSPacker <> xSalesShipmentHeader.RSMUSPacker) or (SalesShipmentHeader.RSMUSLoader <> xSalesShipmentHeader.RSMUSLoader)then IsChanged:=true;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", 'OnBeforeSalesShptHeaderModify', '', false, false)]
    local procedure ShipmentHeaderEdit_OnBeforeSalesShptHeaderModify(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader.RSMUSPuller:=FromSalesShptHeader.RSMUSPuller;
        SalesShptHeader.RSMUSPacker:=FromSalesShptHeader.RSMUSPacker;
        SalesShptHeader.RSMUSLoader:=FromSalesShptHeader.RSMUSLoader;
    end;
//RSM11506 <<
}

codeunit 50103 "RSMUSPurchEventSubscribers"
{
    //RSM10332 BJK 10/31/2022 BRD-0009: Purchase Order Report
    //RSM14788 JRO 2023-08-10 BRD-0011: Purchase Order report modifications
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure PurchaseLine_OnAfterValidateEvent_No(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        if(Rec."Document Type" = Rec."Document Type"::Order) AND (Rec.Type = Rec.Type::Item)then PurchManagementCU.SetCOARequired(Rec);
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure PurchaseLine_OnAfterDeleteEvent(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then PurchManagementCU.CheckCOARequired(Rec);
    end;
    [EventSubscriber(ObjectType::codeunit, codeunit::"Req. Wksh.-Make Order", 'OnAfterInsertPurchOrderHeader', '', false, false)]
    local procedure OnAfterInsertPurchOrderHeader_ReqWkshMakeOrder(var RequisitionLine: Record "Requisition Line"; var PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean; SpecialOrder: Boolean)
    begin
        PurchaseOrderHeader.OnAfterInsertPurchOrderHeader_ReqWkshMakeOrder(RequisitionLine); //RSM14788
    end;
    var PurchManagementCU: Codeunit RSMUSPurchManagement;
}

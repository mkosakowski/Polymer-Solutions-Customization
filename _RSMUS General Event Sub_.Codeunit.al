codeunit 50102 "RSMUS General Event Sub"
{
    //RSM10333 MGZ 09/19/22 BRD-0015: Gensis: Vendor Re-Order Qty notification
    //RSM10331 MGZ 09/28/22 BRD-0004: Add custom attachments logic to pikcup customer no. and ship-to code
    //RSM10294 BJK 11/14/22 BRD-0005: Customer Specific Cert of Analysis
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    //RSM10564 BJK 12/12/2022 BRD-0042: 7th Ave Transfer Process
    //RSM9932 BJK 01/12/2023 BRD-0013: Transfer Order Modifications
    //RSM11506 BJK 2023-02-23 BRD-0024: Posted Sales Shipment Packing Slip
    //RSM13245 BJK 2023-05-02 ADHOC: Manufacturing Date
    Permissions = tabledata "Sales Shipment Header"=m;

    //RSM10333 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeManualReleasePurchaseDoc', '', False, False)]
    local procedure CReleasePurchDoc_OnBeforeManualReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
        //   PriceListHdr: Record "Price List Header";
        PriceListLine: Record "Price List Line";
        PriceListLine2: Record "Price List Line";
    begin
        if PurchaseHeader.IsTemporary() or (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order)then exit;
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        If PurchaseLine.FindSet()then repeat PriceListLine.Reset();
                PriceListLine.SetRange("Source Type", PriceListLine."Source Type"::Vendor);
                PriceListLine.SetRange("Assign-to No.", PurchaseHeader."Buy-from Vendor No.");
                PriceListLine.SetRange("Asset Type", PriceListLine."Asset Type"::Item);
                PriceListLine.SetRange("Asset No.", PurchaseLine."No.");
                PriceListLine.SetRange("Direct Unit Cost", PurchaseLine."Direct Unit Cost");
                PriceListLine.SetRange("Unit of Measure Code", PurchaseLine."Unit of Measure Code");
                If PriceListLine.FindFirst()then begin
                    PriceListLine2.Reset();
                    PriceListLine2.SetRange("Price List Code", PriceListLine."Price List Code");
                    PriceListLine2.SetFilter("Source Type", 'Vendor');
                    PriceListLine2.SetFilter("Asset Type", 'Item');
                    PriceListLine2.SetFilter("Asset No.", PriceListLine."Asset No.");
                    PriceListLine2.SetFilter("Unit of Measure Code", PriceListLine."Unit of Measure Code");
                    PriceListLine2.SetFilter("Line No.", '>%1', PriceListLine."Line No.");
                    If PriceListLine2.FindFirst()then Message('You are %1 %2 from reaching the next quantity break for Item %3 which will change the unit cost to %4', PriceListLine2."Minimum Quantity" - PurchaseLine.Quantity, PriceListLine."Unit of Measure Code", PriceListLine2."Asset No.", PriceListLine2."Direct Unit Cost");
                end until PurchaseLine.Next() = 0;
    end;
    //RSM10333 <<
    //RSM10331 >>
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', False, False)]
    local procedure PDocAttachDetail_OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef1: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of DATABASE::"RSMUS DDMS Master": begin
            FieldRef1:=RecRef.Field(1);
            RecNo:=FieldRef1.Value;
            DocumentAttachment.SetRange("No.", RecNo);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', False, False)]
    local procedure TDocAttach_OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef1: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of DATABASE::"RSMUS DDMS Master": begin
            FieldRef1:=RecRef.Field(1);
            RecNo:=FieldRef1.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
        end;
    end;
    //RSM10331 >>
    //RSM10294 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RSMUS QM Quality Management", 'OnBeforeInsertQOLines', '', false, false)]
    local procedure RSMUSQMQualityManagement_OnBeforeInsertQOLines(var QualityHeader: Record "RSMUS QM Quality Header"; var IsHandled: Boolean)
    var
        QualityLine: Record "RSMUS QM Quality Line";
        InsertQualityLine: Record "RSMUS QM Quality Line";
        QMTestMethod: Record "RSMUS QM Test Method";
        ItemQualityChar: Record "RSMUS QM Item Quality Char.";
        LineNo: Integer;
    begin
        IsHandled:=true;
        QualityLine.Reset();
        QualityLine.SetRange("RSMUS QM Document Type", QualityHeader."RSMUS QM Document Type");
        QualityLine.SetRange("RSMUS QM Document No.", QualityHeader."RSMUS QM Document No.");
        QualityLine.SetRange("RSMUS QM No.", QualityHeader."RSMUS QM No.");
        if QualityLine.FindLast()then LineNo:=QualityLine."RSMUS QM Line No.";
        LineNo+=10000;
        ItemQualityChar.Reset();
        ItemQualityChar.SetRange("RSMUS QM Item No.", QualityHeader."RSMUS QM Item No.");
        ItemQualityChar.SetRange("RSMUS QM Variant Code", QualityHeader."RSMUS QM Variant Code");
        ItemQualityChar.SetRange("RSMUS QM Sales Type", ItemQualityChar."RSMUS QM Sales Type"::"All Customers");
        if ItemQualityChar.FindSet()then repeat QualityLine.Reset();
                QualityLine.SetRange("RSMUS QM Document Type", QualityHeader."RSMUS QM Document Type");
                QualityLine.SetRange("RSMUS QM Document No.", QualityHeader."RSMUS QM Document No.");
                QualityLine.SetRange("RSMUS QM No.", QualityHeader."RSMUS QM No.");
                QualityLine.SetRange("RSMUS QM Quality Char. Code", ItemQualityChar."RSMUS QM Quality Char. Code");
                QualityLine.SetFilter("RSMUS QM Cust Test", '%1', '');
                if QualityLine.IsEmpty then begin
                    // with InsertQualityLine do begin
                    InsertQualityLine.Init();
                    InsertQualityLine."RSMUS QM Document Type":=QualityHeader."RSMUS QM Document Type";
                    InsertQualityLine."RSMUS QM No.":=QualityHeader."RSMUS QM No.";
                    InsertQualityLine."RSMUS QM Line No.":=LineNo;
                    InsertQualityLine."RSMUS QM Item No.":=QualityHeader."RSMUS QM Item No.";
                    InsertQualityLine."RSMUS QM Variant Code":=QualityHeader."RSMUS QM Variant Code";
                    InsertQualityLine."RSMUS QM Location Code":=QualityHeader."RSMUS QM Location Code";
                    InsertQualityLine."RSMUS QM Lot No.":=QualityHeader."RSMUS QM Lot No.";
                    InsertQualityLine."RSMUS QM Serial No.":=QualityHeader."RSMUS QM Serial No.";
                    InsertQualityLine."RSMUS QM Quality Char. Code":=ItemQualityChar."RSMUS QM Quality Char. Code";
                    InsertQualityLine."RSMUS QM Type":=ItemQualityChar."RSMUS QM Type";
                    InsertQualityLine."RSMUS QM Test Method":=ItemQualityChar."RSMUS QM Test Method";
                    InsertQualityLine."RSMUS QM Characteristic UoM":=ItemQualityChar."RSMUS QM Characteristic UoM";
                    InsertQualityLine.Validate("RSMUS QM Lower Limit", ItemQualityChar."RSMUS QM Lower Limit");
                    InsertQualityLine.Validate("RSMUS QM Upper Limit", ItemQualityChar."RSMUS QM Upper Limit");
                    InsertQualityLine.Validate("RSMUS QM Nominal Value", ItemQualityChar."RSMUS QM Nominal Value");
                    InsertQualityLine.RSMUSCOALowerLimit:=ItemQualityChar.RSMUSCOALowerLimit;
                    InsertQualityLine.RSMUSCOAUpperLimit:=ItemQualityChar.RSMUSCOAUpperLimit;
                    InsertQualityLine.RSMUSCOANominalValue:=ItemQualityChar.RSMUSCOANominalValue;
                    InsertQualityLine."RSMUS QM Test Required":=ItemQualityChar."RSMUS QM Test Required";
                    //InsertQualityLine."RSMUS QM Test Validation Notif" := ItemQualityChar."RSMUS QM Test Validation Notif";
                    //IF "Test Validation Notification" = "Test Validation Notification"::Error THEN
                    //  "Test Result" := "Test Result"::Failed
                    //ELSE
                    //  "Test Result" := "Test Result"::Warning;
                    InsertQualityLine."RSMUS QM Test Result":=InsertQualityLine."RSMUS QM Test Result"::"Not Tested";
                    InsertQualityLine."RSMUS QM Print on CoA":=ItemQualityChar."RSMUS QM Print on COA";
                    InsertQualityLine."RSMUS QM Testing UoM":=ItemQualityChar."RSMUS QM Testing UoM";
                    InsertQualityLine."RSMUS QM Attribute Name":=ItemQualityChar."RSMUS QM Attribute Name";
                    InsertQualityLine."RSMUS QM Attribute ID":=ItemQualityChar."RSMUS QM Attribute ID";
                    InsertQualityLine."RSMUS QM Attribute Type":=ItemQualityChar."RSMUS QM Attribute Type";
                    QMTestMethod.Reset();
                    QMTestMethod.SetRange("RSMUS QM Code", InsertQualityLine."RSMUS QM Test Method");
                    if QMTestMethod.FindFirst()then InsertQualityLine."RSMUS QM Destructive":=QMTestMethod."RSMUS QM Destructive";
                    InsertQualityLine.Insert();
                    LineNo:=LineNo + 10000;
                end;
            //end;
            until ItemQualityChar.Next() = 0;
        OnAfterInsertQOLines(QualityHeader);
    end;
    [EventSubscriber(ObjectType::Table, Database::"RSMUS QM Quality Line", 'OnBeforeInsertEvent', '', false, false)]
    local procedure RSMUSQMQualityLine_OnBeforeInsertEvent(var Rec: Record "RSMUS QM Quality Line"; RunTrigger: Boolean)
    var
        ItemQualityChar: Record "RSMUS QM Item Quality Char.";
    begin
        ItemQualityChar.SetRange("RSMUS QM Item No.", Rec."RSMUS QM Item No.");
        ItemQualityChar.SetRange("RSMUS QM Variant Code", Rec."RSMUS QM Variant Code");
        ItemQualityChar.SetRange("RSMUS QM Quality Char. Code", Rec."RSMUS QM Quality Char. Code");
        ItemQualityChar.SetRange("RSMUS QM Sales Code", Rec."RSMUS QM Cust Test");
        if ItemQualityChar.FindFirst()then begin
            Rec.RSMUSCOALowerLimit:=ItemQualityChar.RSMUSCOALowerLimit;
            Rec.RSMUSCOAUpperLimit:=ItemQualityChar.RSMUSCOAUpperLimit;
            Rec.RSMUSCOANominalValue:=ItemQualityChar.RSMUSCOANominalValue;
        end;
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertQOLines(var QualityHeader: Record "RSMUS QM Quality Header")
    begin
    end;
    //RSM10294 <<
    //RSM10564 >>
    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure TransferHeader_OnAfterDeleteEvent(var Rec: Record "Transfer Header"; RunTrigger: Boolean)
    var
        ProdOrderComponent: Record "Prod. Order Component";
        TransferReceiptHeader: Record "Transfer Receipt Header";
    begin
        TransferReceiptHeader.SetRange("Transfer Order No.", Rec."No.");
        if TransferReceiptHeader.FindFirst()then exit;
        ProdOrderComponent.SetRange(RSMUSTransferOrderNo, Rec."No.");
        if ProdOrderComponent.FindSet()then repeat ProdOrderComponent.Validate(RSMUSTransferOrderNo, '');
                ProdOrderComponent.Modify();
            until ProdOrderComponent.Next() = 0;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure TransferLine_OnAfterDeleteEvent(var Rec: Record "Transfer Line"; RunTrigger: Boolean)
    var
        ProdOrderComponent: Record "Prod. Order Component";
    begin
        if(Rec.RSMUSProdOrderCompNo <> '') AND (ProdOrderComponent.Get(Rec.RSMUSProdOrderCompStatus, Rec.RSMUSProdOrderCompNo, Rec.RSMUSProdOrderCompOrderLineNo, Rec.RSMUSProdOrderCompLineNo))then begin
            if ProdOrderComponent.RSMUSTransferOrderNo <> '' then begin
                ProdOrderComponent.Validate(RSMUSTransferOrderNo, '');
                ProdOrderComponent.Modify();
            end;
        end;
    end;
    //RSM10564 <<
    //RSM9932 >>
    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterValidateEvent', 'Item No.', false, false)]
    local procedure TransferLine_OnAfterValidateEvent_ItemNo(var Rec: Record "Transfer Line"; var xRec: Record "Transfer Line"; CurrFieldNo: Integer)
    var
        lCust: Record Customer;
        TransferHeader: Record "Transfer Header";
        ItemReference: Record "Item Reference";
    begin
        if TransferHeader.Get(Rec."Document No.")then begin
            If lCust.Get(TransferHeader."RSMUS Customer No.")then begin
                Clear(ItemReference);
                ItemReference.SetRange("Item No.", Rec."Item No.");
                ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::Customer);
                ItemReference.SetRange("Reference Type No.", lCust."No.");
                if ItemReference.FindFirst()then begin
                    Rec."RSMUS Item Reference No.":=ItemReference."Reference No.";
                    Rec.Description:=ItemReference.Description;
                end;
            end;
        end;
    end;
    //RSM9932 <<
    //RSM11506 >
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnAfterCreatePostedShptHeader', '', false, false)]
    local procedure MyProcedure2(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var PostedWhseShptHeader: Record "Posted Whse. Shipment Header")
    var
        RSMUSRegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        RSMUSUser: Record User;
    begin
        PostedWhseShptHeader.RSMUSPacker:=WarehouseShipmentHeader.RSMUSPacker;
        PostedWhseShptHeader.RSMUSLoader:=WarehouseShipmentHeader.RSMUSLoader;
        PostedWhseShptHeader.RSMUSWarehouseShipmentDate:=DT2Date(WarehouseShipmentHeader.SystemCreatedAt);
        RSMUSRegisteredWhseActivityLine.SetRange("Whse. Document Type", RSMUSRegisteredWhseActivityLine."Whse. Document Type"::Shipment);
        RSMUSRegisteredWhseActivityLine.SetRange("Whse. Document No.", WarehouseShipmentHeader."No.");
        if RSMUSRegisteredWhseActivityLine.FindSet()then repeat Clear(RSMUSUser);
                if RSMUSUser.Get(RSMUSRegisteredWhseActivityLine.SystemModifiedBy)then begin
                    PostedWhseShptHeader.RSMUSPuller:=RSMUSUser."User Name";
                    break;
                end;
            until RSMUSRegisteredWhseActivityLine.Next() = 0;
        PostedWhseShptHeader.Modify();
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnCreatePostedShptLineOnBeforePostWhseJnlLine', '', false, false)]
    local procedure MyProcedure3(var PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; var TempTrackingSpecification: Record "Tracking Specification" temporary; WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";
    begin
        SalesShipmentHeader.SetRange("Posting Date", PostedWhseShipmentLine."Posting Date");
        SalesShipmentHeader.SetRange("No.", PostedWhseShipmentLine."Posted Source No.");
        if SalesShipmentHeader.FindFirst()then begin
            if PostedWhseShipmentHeader.Get(PostedWhseShipmentLine."No.")then begin
                SalesShipmentHeader.RSMUSPuller:=PostedWhseShipmentHeader.RSMUSPuller;
                SalesShipmentHeader.RSMUSPacker:=PostedWhseShipmentHeader.RSMUSPacker;
                SalesShipmentHeader.RSMUSLoader:=PostedWhseShipmentHeader.RSMUSLoader;
                SalesShipmentHeader.RSMUSWarehouseShipmentDate:=PostedWhseShipmentHeader.RSMUSWarehouseShipmentDate;
                SalesShipmentHeader.Modify();
            end;
        end;
    end;
    //RSM11506 <<
    //RSM13245 >>
    // [EventSubscriber(ObjectType::Table, Database::"Lot No. Information", 'OnAfterInsertEvent', '', false, false)]
    // local procedure MyProcedure(var Rec: Record "Lot No. Information"; RunTrigger: Boolean)
    // end;
    //Done this way because above event subscriber does not seem to work, this seems to be the way the product team does it
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterValidateEvent', 'Lot No.', false, false)]
    local procedure ItemTrackingLines_OnAfterValidateEvent_LotNo(var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification")
    var
        LotNoInformation: Record "Lot No. Information";
        ProdOrderLine: Record "Prod. Order Line";
        ItemJournalLine: Record "Item Journal Line";
    begin
        if Rec."Source Type" = Database::"Prod. Order Line" then begin
            if ProdOrderLine.Get(Rec."Source Subtype", Rec."Source ID", Rec."Source Prod. Order Line")then begin
                if LotNoInformation.Get(ProdOrderLine."Item No.", ProdOrderLine."Variant Code", Rec."Lot No.")then begin
                    if(LotNoInformation.RSMUSManufacturingDate = 0D)then begin
                        LotNoInformation.RSMUSManufacturingDate:=ProdOrderLine."Starting Date";
                        LotNoInformation.Modify();
                    end;
                end;
            end;
        end;
        if Rec."Source Type" = Database::"Item Journal Line" then begin
            if ItemJournalLine.Get(Rec."Source ID", Rec."Source Batch Name", Rec."Source Ref. No.")then begin
                ProdOrderLine.SetRange("Prod. Order No.", ItemJournalLine."Order No.");
                ProdOrderLine.SetRange("Line No.", ItemJournalLine."Order Line No.");
                if ProdOrderLine.FindFirst()then begin
                    if LotNoInformation.Get(ProdOrderLine."Item No.", ProdOrderLine."Variant Code", Rec."Lot No.")then begin
                        if(LotNoInformation.RSMUSManufacturingDate = 0D)then begin
                            LotNoInformation.RSMUSManufacturingDate:=ProdOrderLine."Starting Date";
                            LotNoInformation.Modify();
                        end;
                    end;
                end;
            end;
        end;
    end;
//RSM13245 <<
}

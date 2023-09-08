reportextension 50106 "RSMUSProdOrderJobCard" extends "Prod. Order - Job Card" //99000762
{
    //RSM11851 BJK 2023-04-05 BRD-0047 Production Order Job Card
    dataset
    {
        add("Production Order")
        {
            column(RSMUSNo; RSMUSEncodedText)
            {
            }
            column(RSMUSCustomerNo; "RSMUS_BTI Customer No.")
            {
            }
            column(RSMUSCustomerName; "RSMUS_BTI Customer Name")
            {
            }
            column(RSMUSReference; RSMUSReference)
            {
            }
            column(RSMUSLotNo; RSMUSLotNo)
            {
            }
            column(RSMUSVariantCode; "Variant Code")
            {
            }
            column(RSMUSQuantity; Format(RSMUSQuantity))
            {
            }
            column(RSMUSUOM; RSMUSUOM)
            {
            }
            column(RSMUSProdBOMNo; RSMUSProdBOMNo)
            {
            }
            column(RSMUSProdBOMDescription; RSMUSProdBOMDescription)
            {
            }
        }
        modify("Production Order")
        {
        trigger OnAfterAfterGetRecord()
        var
            ItemReference: Record "Item Reference";
            ProdOrderLine: Record "Prod. Order Line";
            tempTrackingSpecification: Record "Tracking Specification" temporary;
            RSMUSProductionBOMHeader: Record "Production BOM Header";
            lItemTrackingLines: Page "RSMUSItem Tracking Lines";
            BarcodeString: Text;
            BarcodeSymbology: Enum "Barcode Symbology 2D";
            BarcodeFontProvider: Interface "Barcode Font Provider 2D";
        begin
            BarcodeFontProvider:=Enum::"Barcode Font Provider 2D"::IDAutomation2D;
            BarcodeSymbology:=Enum::"Barcode Symbology 2D"::"QR-Code";
            BarcodeString:="No.";
            RSMUSEncodedText:=BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            if("Production Order"."RSMUS_BTI Customer No." <> '') AND ("Production Order"."Source Type" = "Production Order"."Source Type"::Item)then begin
                ItemReference.SetRange("Item No.", "Production Order"."Source No.");
                ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::Customer);
                ItemReference.SetRange("Reference Type No.", "Production Order"."RSMUS_BTI Customer No.");
                ItemReference.SetRange("Variant Code", "Production Order"."Variant Code");
                if ItemReference.FindFirst()then begin
                    RSMUSReferenceNo:=ItemReference."Reference No.";
                    RSMUSReferenceDescription:=ItemReference.Description;
                    RSMUSReference:=Format(RSMUSReferenceNo) + ' ' + RSMUSReferenceDescription;
                end;
            end;
            ProdOrderLine.SetRange(Status, "Production Order".Status);
            ProdOrderLine.SetRange("Prod. Order No.", "Production Order"."No.");
            if ProdOrderLine.FindFirst()then begin
                tempTrackingSpecification.InitFromProdOrderLine(ProdOrderLine);
                RSMUSLotNo:=lItemTrackingLines.SetSourceSpec(tempTrackingSpecification, ProdOrderLine."Due Date");
                RSMUSQuantity:=ProdOrderLine.Quantity;
                RSMUSUOM:=ProdOrderLine."Unit of Measure Code";
                RSMUSProdBOMNo:=ProdOrderLine."Production BOM No.";
                if RSMUSProductionBOMHeader.Get(RSMUSProdBOMNo)then RSMUSProdBOMDescription:=RSMUSProductionBOMHeader.Description;
            end;
        end;
        }
        addlast("Production Order")
        {
            dataitem("RSMUSProdOrderLine"; "Prod. Order Line")
            {
                DataItemLink = Status=FIELD(Status), "Prod. Order No."=FIELD("No.");

                dataitem("RSMUSProdOrderComponent"; "Prod. Order Component")
                {
                    DataItemLink = Status=FIELD(Status), "Prod. Order No."=FIELD("Prod. Order No."), "Prod. Order Line No."=field("Line No.");

                    column(RSMUSItem_No_; "Item No.")
                    {
                    }
                    column(RSMUSDescription; Description)
                    {
                    }
                    column(RSMUSExpected_Quantity; "Expected Quantity")
                    {
                    }
                    column(RSMUSUnit_of_Measure_Code; "Unit of Measure Code")
                    {
                    }
                    column(RSMUSLotNoComponent; RSMUSLotNoComponent)
                    {
                    }
                    column(RSMUSLine_No_; "Line No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        ReservationEntry: Record "Reservation Entry";
                    begin
                        RSMUSLotNoComponent:='';
                        ReservationEntry.SetRange("Item No.", RSMUSProdOrderComponent."Item No.");
                        ReservationEntry.SetRange("Location Code", RSMUSProdOrderComponent."Location Code");
                        ReservationEntry.SetRange("Source Type", 5407);
                        ReservationEntry.SetRange("Source ID", RSMUSProdOrderLine."Prod. Order No.");
                        ReservationEntry.SetRange("Source Prod. Order Line", RSMUSProdOrderLine."Line No.");
                        ReservationEntry.SetRange("Source Ref. No.", RSMUSProdOrderComponent."Line No.");
                        ReservationEntry.SetRange("Variant Code", RSMUSProdOrderComponent."Variant Code");
                        if ReservationEntry.FindFirst()then RSMUSLotNoComponent:=ReservationEntry."Lot No.";
                    end;
                }
            }
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Caption = 'PSG Prod Order Job Card';
            Summary = 'PSG Prod Order Job Card';
            Type = RDLC;
            LayoutFile = './src/ReportExt/Layouts/Rep99000762-Ext50106.RSMUSProdOrderJobCard.rdl';
        }
    }
    var ItemTrackingDataCollectionCU: Codeunit RSMUSItemTrackingDataCollect;
    RSMUSEncodedText: Text;
    RSMUSReferenceNo: Code[50];
    RSMUSReferenceDescription: Text[100];
    RSMUSReference: Text[151];
    RSMUSLotNo: Code[50];
    RSMUSLotNoComponent: Code[50];
    RSMUSQuantity: Decimal;
    RSMUSUOM: Code[10];
    RSMUSProdBOMNo: Code[20];
    RSMUSProdBOMDescription: Text[100];
    FirstLineBool: Boolean;
}

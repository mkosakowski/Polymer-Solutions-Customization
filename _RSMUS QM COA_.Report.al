report 50108 "RSMUS QM COA"
{
    //RSM10294 MGZ 10/05/22 BRD-0005: Customer COA Report
    //RSM10294 BJK 11/14/22 BRD-0005: Customer Specific Cert of Analysis
    // Report RSMUS QM Cert Of Analysis (ID 60001).
    Caption = 'RSMUS Certificate of Analysis';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layouts/Rep50108.RSMUSQMCOA.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(TestLog; "RSMUS QM Qual Mgmt Test Log")
        {
            DataItemTableView = SORTING("RSMUS QM Item No.", "RSMUS QM Lot No.", "RSMUS QM Quality Char. Code")ORDER(Descending);
            RequestFilterFields = "RSMUS QM Item No.", "RSMUS QM Lot No.", "RSMUS QM Pstd Qlity. Order No.";

            column(RSMUSCompanyInfoPicture; RSMUSCompanyInfo.Picture)
            {
            }
            column(gAddress; gAddress)
            {
            }
            column(gCompanyDetails; gCompanyDetails)
            {
            }
            column(RSMUSExternalDoc; WhseShpmntHeader."External Document No.")
            {
            }
            column(RSMUShipDate; WhseShpmntHeader."Shipment Date")
            {
            }
            column(RSMUSCustNo; gCustomer."No.")
            {
            }
            column(RSMUSNIFNo; gCustomer."RSMUS NIF No.")
            {
            }
            column(RSMUSCustName; gCustomer.Name)
            {
            }
            column(RSMUSProductDesc; gProductDesc)
            {
            }
            column(RSMUSWhseShpmntQty; WhseShpmntQty)
            {
            }
            column(RSMUSWhseShpmntUOM; WhseShpmntUOM)
            {
            }
            column(RSMUSItemRefDesc; gItemRefDesc)
            {
            }
            column(RSMUSItemNo; gRSMUSItemNo)
            {
            }
            column(RSMUSTester; gTesterName)
            {
            }
            column(RSMUSTestedDate; TestLog."RSMUS QM Test Date/Time")
            {
            }
            column(RSMUSBatch; gBatch)
            {
            }
            column(RSMUSBatchQuantity; RSMUSBatchQuantity)
            {
            }
            column(RSMUSBatchSizeQuantity; RSMUSBatchSizeQuantity)
            {
            }
            column(PrintQuantities; PrintQuantities)
            {
            }
            column(RSMUSSpecDate; gSpecDate)
            {
            }
            column(RSMUSCrossRef; gCrossRef)
            {
            }
            column(RSMUSShelfLife; gShelfLife)
            {
            }
            column(RSMUSManufactureDate; gManufactureDate)
            {
            }
            column(RSMUSExpirationDate; gExpirationDate)
            {
            }
            column(RSMUSPSGCoAEmail; gQMSetup."RSMUS PSG CoA Email")
            {
            }
            column(RSMUSRevision; gQMSetup."RSMUS Revision")
            {
            }
            column(RSMUSPlantID; gPlantID)
            {
            }
            column(NIFNoBlank; NIFNoBlank)
            {
            }
            column(gVariantCode; gVariantCode)
            {
            }
            column(gVariantCodeBlank; gVariantCodeBlank)
            {
            }
            trigger OnAfterGetRecord()
            var
                postedQuaOrder: Record "RSMUS QM Posted Quality Line";
                lWhseShpmntLine: Record "Warehouse Shipment Line";
                QMPostedQualityHeader: Record "RSMUS QM Posted Quality Header";
                lItem: Record Item;
                lItemReference: Record "Item Reference";
                lILE: Record "Item Ledger Entry";
                HeaderItemUnitOfMeasure: Record "Item Unit of Measure";
                BatchItemUnitOfMeasure: Record "Item Unit of Measure";
                LineUnitOfMeasure: Record "Item Unit of Measure";
                BatchShippedUOM: Record "Item Unit of Measure";
                RSMUSPostedQualityHeader: Record "RSMUS QM Posted Quality Header";
                RSMUSProductionOrder: Record "Production Order";
                lRSMUSPostedQualityHeader: Record "RSMUS QM Posted Quality Header";
                lLotNoInformation: Record "Lot No. Information";
            begin
                //if CharCode1 <> "RSMUS QM Quality Char. Code" then begin
                postedQuaOrder.SetRange("RSMUS QM No.", TestLog."RSMUS QM Pstd Qlity. Order No.");
                postedQuaOrder.SetRange("RSMUS QM Item No.", "RSMUS QM Item No.");
                postedQuaOrder.SetRange("RSMUS QM Variant Code", "RSMUS QM Variant No.");
                postedQuaOrder.SetRange("RSMUS QM Quality Char. Code", "RSMUS QM Quality Char. Code");
                postedQuaOrder.SetRange("RSMUS QM Print on COA", true);
                if postedQuaOrder.FindSet()then repeat clear(TempQualMgmtTestLog);
                        TempQualMgmtTestLog.setrange("RSMUS QM Item No.", TestLog."RSMUS QM Item No.");
                        if TestLog."RSMUS QM Variant No." = '' then TempQualMgmtTestLog.setfilter("RSMUS QM Variant No.", '%1', '')
                        else
                            TempQualMgmtTestLog.setrange("RSMUS QM Variant No.", TestLog."RSMUS QM Variant No.");
                        if TestLog."RSMUS QM Lot No." = '' then TempQualMgmtTestLog.setfilter("RSMUS QM Lot No.", '%1', '')
                        else
                            TempQualMgmtTestLog.setrange("RSMUS QM Lot No.", TestLog."RSMUS QM Lot No.");
                        if TestLog."RSMUS QM serial No." = '' then TempQualMgmtTestLog.setfilter("RSMUS QM serial No.", '%1', '')
                        else
                            TempQualMgmtTestLog.setrange("RSMUS QM serial No.", TestLog."RSMUS QM serial No.");
                        TempQualMgmtTestLog.setrange("RSMUS QM Quality Char. Code", TestLog."RSMUS QM Quality Char. Code");
                        if not TempQualMgmtTestLog.findfirst()then begin
                            TempQualMgmtTestLog.Init();
                            TempQualMgmtTestLog:=TestLog;
                            TempQualMgmtTestLog.Insert();
                        end;
                        Clear(lRSMUSPostedQualityHeader);
                        if(gTesterName = '') AND lRSMUSPostedQualityHeader.Get(postedQuaOrder."RSMUS QM Document Type", postedQuaOrder."RSMUS QM No.")then gTesterName:=lRSMUSPostedQualityHeader."RSMUS QM Tester Name";
                    until(postedQuaOrder.Next() = 0);
                clear(TempQualMgmtTestLog);
                Clear(gAddress);
                Clear(gPlantID);
                gAddress:=getLocationAddress(gWhseShpmntNo);
                If WhseShpmntHeader.Get(gWhseShpmntNo)then begin
                    lWhseShpmntLine.SetRange("No.", gWhseShpmntNo);
                    If lWhseShpmntLine.FindFirst()then begin
                        WhseShpmntQty:=lWhseShpmntLine."Qty. to Ship";
                        WhseShpmntUOM:=lWhseShpmntLine."Unit of Measure Code" + ':';
                        gSO.SetRange("No.", lWhseShpmntLine."Source No.");
                        If gSO.FindFirst()then begin
                            gPlantID:=gSO."RSMUS Final Destination";
                            If gCustomer.get(gSO."Sell-to Customer No.")then if gCustomer."RSMUS NIF No." <> '' then NIFNoBlank:=false;
                        end;
                    end end;
                Clear(gProductDesc);
                Clear(gItemRefDesc);
                Clear(gCrossRef);
                Clear(gSpecDate);
                Clear(gShelfLife);
                If lItem.Get(TestLog."RSMUS QM Item No.")then begin
                    gRSMUSItemNo:=lItem."No.";
                    gProductDesc:=lItem."RSMUS Product Description";
                    // gShelfLife := lItem."RSMUS Shelf Life";
                    lItemReference.SetRange("Item No.", TestLog."RSMUS QM Item No.");
                    lItemReference.SetRange("Reference Type", lItemReference."Reference Type"::Customer);
                    lItemReference.SetRange("Reference Type No.", gSO."Sell-to Customer No.");
                    If lItemReference.FindFirst()then begin
                        gItemRefDesc:=lItemReference.Description;
                        gCrossRef:=lItemReference."Reference No.";
                        gSpecDate:=lItemReference."RSMUS Specification Date";
                        gShelfLife:=lItemReference."RSMUS Shelf Life";
                    end;
                    if format(gShelfLife) = '' then gShelfLife:=lItem."RSMUS Shelf Life";
                end;
                if gItemRefDesc = '' then gItemRefDesc:=lItem.Description;
                Clear(gManufactureDate);
                Clear(gExpirationDate);
                //lILE.SetRange("RSMUS QM Posted Qual Order No.", TestLog."RSMUS QM Pstd Qlity. Order No.");
                //If lILE.FindFirst() then begin
                if TestLog."RSMUS QM Document Type" = TestLog."RSMUS QM Document Type"::Production then if RSMUSPostedQualityHeader.Get(TestLog."RSMUS QM Document Type", TestLog."RSMUS QM Pstd Qlity. Order No.")then begin
                        RSMUSProductionOrder.SetRange("No.", RSMUSPostedQualityHeader."RSMUS QM Document No.");
                        if RSMUSProductionOrder.FindFirst()then begin
                        end;
                    end;
                if gQMSetup.Get()then;
                if QMPostedQualityHeader.Get(TestLog."RSMUS QM Document Type", TestLog."RSMUS QM Pstd Qlity. Order No.")then begin
                    gVariantCode:=QMPostedQualityHeader."RSMUS QM Variant Code";
                    if HeaderItemUnitOfMeasure.Get(QMPostedQualityHeader."RSMUS QM Item No.", lILE."Unit of Measure Code")then;
                    if BatchItemUnitOfMeasure.Get(QMPostedQualityHeader."RSMUS QM Item No.", gBatch)then;
                    QMPostedQualityHeader.CalcFields("RSMUS QM Total Quantity");
                    if LineUnitOfMeasure.Get(lWhseShpmntLine."Item No.", lWhseShpmntLine."Unit of Measure Code")then;
                    if gBatch = '' then gBatch:=LineUnitOfMeasure.Code;
                    if gBatchSizeShipped = '' then gBatchSizeShipped:=LineUnitOfMeasure.Code;
                    if(LineUnitOfMeasure."Qty. per Unit of Measure" <> 0) AND (BatchItemUnitOfMeasure."Qty. per Unit of Measure" <> 0)then RSMUSBatchQuantityDec:=lWhseShpmntLine."Qty. to Ship" * (LineUnitOfMeasure."Qty. per Unit of Measure" / BatchItemUnitOfMeasure."Qty. per Unit of Measure");
                    RSMUSBatchQuantity:=Format(Round(RSMUSBatchQuantityDec, 0.0001, '=')) + ' ' + Format(gBatch);
                    if BatchShippedUOM.Get(QMPostedQualityHeader."RSMUS QM Item No.", gBatchSizeShipped) AND (LineUnitOfMeasure."Qty. per Unit of Measure" <> 0) AND (BatchItemUnitOfMeasure."Qty. per Unit of Measure" <> 0)then RSMUSBatchSizeQuantityDec:=lWhseShpmntLine."Qty. to Ship" * (LineUnitOfMeasure."Qty. per Unit of Measure" / BatchShippedUOM."Qty. per Unit of Measure");
                    RSMUSBatchSizeQuantity:=Format(Round(RSMUSBatchSizeQuantityDec, 0.0001, '=')) + ' ' + Format(gBatchSizeShipped);
                end;
                if gVariantCode <> '' then gVariantCodeBlank:=false;
                if lLotNoInformation.Get(TestLog."RSMUS QM Item No.", TestLog."RSMUS QM Variant No.", TestLog."RSMUS QM Lot No.")then begin
                    gManufactureDate:=lLotNoInformation.RSMUSManufacturingDate;
                    if gManufactureDate <> 0D then gExpirationDate:=System.CalcDate(gShelfLife, gManufactureDate);
                end;
            end;
        }
        dataitem(QMLog2; "Integer")
        {
            DataItemTableView = SORTING(Number);

            column(CoInfo1Pix; CompanyInformation1.Picture)
            {
            }
            column(CoInfo2Pix; CompanyInformation2.Picture)
            {
            }
            column(CoInfo3Pix; CompanyInformation3.Picture)
            {
            }
            column(CompanyAddress1; CompanyAddress[1])
            {
            }
            column(CompanyAddress2; CompanyAddress[2])
            {
            }
            column(CompanyAddress3; CompanyAddress[3])
            {
            }
            column(CompanyAddress4; CompanyAddress[4])
            {
            }
            column(CompanyAddress5; CompanyAddress[5])
            {
            }
            column(CompanyAddress6; CompanyAddress[6])
            {
            }
            column(CompanyAddress7; CompanyAddress[7])
            {
            }
            column(CompanyAddress8; CompanyAddress[8])
            {
            }
            column(CompanyAddress9; CompanyAddress[9])
            {
            }
            column(CompanyAddress10; CompanyAddress[10])
            {
            }
            column(CompanyAddress11; CompanyAddress[11])
            {
            }
            column(CompanyAddress12; CompanyAddress[12])
            {
            }
            column(QMItem; TempQualMgmtTestLog."RSMUS QM Item No.")
            {
            }
            column(QMLot; TempQualMgmtTestLog."RSMUS QM Lot No.")
            {
            }
            column(QMSerial; TempQualMgmtTestLog."RSMUS QM Serial No.")
            {
            }
            column(QMLocation; TempQualMgmtTestLog."RSMUS QM Location No.")
            {
            }
            column(QMCharCode; gQualityDescription)
            {
            }
            column(QMTestMeth; gTestMethDescription)
            {
            }
            column(QMCharUOM; TempQualMgmtTestLog."RSMUS QM Characteristic UoM")
            {
            }
            column(QMLower; TempQualMgmtTestLog."RSMUS QM Lower Limit")
            {
            }
            column(QMUpper; TempQualMgmtTestLog."RSMUS QM Upper Limit")
            {
            }
            column(QMNominal; TempQualMgmtTestLog."RSMUS QM Nominal Value")
            {
            }
            column(QMActual; TempQualMgmtTestLog."RSMUS QM Actual Value")
            {
            }
            column(QMTestResult; TempQualMgmtTestLog."RSMUS QM Test Result")
            {
            }
            column(QMExpDate; TempQualMgmtTestLog."RSMUS QM Expiration Date")
            {
            }
            column(QMTestDate; TempQualMgmtTestLog."RSMUS QM Date Logged")
            {
            }
            column(QMTestTime; TempQualMgmtTestLog."RSMUS QM Time Logged")
            {
            }
            column(RSMUSQMTester; TempQualMgmtTestLog."RSMUS QM Tester Name")
            {
            }
            column(RSMUSQMTestedDate; TempQualMgmtTestLog."RSMUS QM Test Date/Time")
            {
            }
            column(QMItemDesc; ItemDesc)
            {
            }
            column(QMQualityCharDesc; QualityCharDesc)
            {
            }
            column(QMTestMethDesc; TestMethDesc)
            {
            }
            column(RSMUSSpec; gSpec)
            {
            }
            column(COASpecification; COASpecification)
            {
            }
            trigger OnAfterGetRecord()
            var
                QMPostedQualityLine: Record "RSMUS QM Posted Quality Line";
                lItemQualityChar: Record "RSMUS QM Item Quality Char.";
                lCustomer: Record Customer;
                lWhseShipmentLine: Record "Warehouse Shipment Line";
                lQMQualityChar: Record "RSMUS QM Quality Char.";
                lQMTestMethod: Record "RSMUS QM Test Method";
            begin
                OnLineNo:=OnLineNo + 1;
                if OnLineNo = 1 then TempQualMgmtTestLog.FindFirst()
                else
                    TempQualMgmtTestLog.Next();
                if Item.Get(TempQualMgmtTestLog."RSMUS QM Item No.")then ItemDesc:=Item.Description;
                Clear(QualityChar);
                if QualityChar.Get(TempQualMgmtTestLog."RSMUS QM Quality Char. Code")then QualityCharDesc:=QualityChar."RSMUS QM Description";
                Clear(TestMethod);
                if TestMethod.Get(TempQualMgmtTestLog."RSMUS QM Test Method")then TestMethDesc:=TestMethod."RSMUS QM Description";
                Clear(gSpec);
                If TempQualMgmtTestLog."RSMUS QM Type" = TempQualMgmtTestLog."RSMUS QM Type"::Decimal then gSpec:=Format(TempQualMgmtTestLog."RSMUS QM Lower Limit") + ' - ' + Format(TempQualMgmtTestLog."RSMUS QM Upper Limit")
                else
                    gSpec:=TempQualMgmtTestLog."RSMUS QM Nominal Value";
                lItemQualityChar.SetRange("RSMUS QM Item No.", TempQualMgmtTestLog."RSMUS QM Item No.");
                lItemQualityChar.SetRange("RSMUS QM Variant Code", TempQualMgmtTestLog."RSMUS QM Variant No.");
                if lWhseShipmentLine.Get(gWhseShpmntNo, gWhseShipmentLineNo) AND lCustomer.Get(lWhseShipmentLine."Destination No.")then lItemQualityChar.SetRange("RSMUS QM Sales Code", lCustomer."No.")
                else
                    lItemQualityChar.SetRange("RSMUS QM Sales Code", '');
                lItemQualityChar.SetRange("RSMUS QM Quality Char. Code", TempQualMgmtTestLog."RSMUS QM Quality Char. Code");
                if lItemQualityChar.FindFirst()then begin
                    if(TempQualMgmtTestLog."RSMUS QM Type" = TempQualMgmtTestLog."RSMUS QM Type"::Decimal) OR (TempQualMgmtTestLog."RSMUS QM Type" = TempQualMgmtTestLog."RSMUS QM Type"::Date)then COASpecification:=Format(lItemQualityChar.RSMUSCOALowerLimit) + ' - ' + Format(lItemQualityChar.RSMUSCOAUpperLimit)
                    else
                        COASpecification:=lItemQualityChar.RSMUSCOANominalValue;
                end
                else
                begin
                    lItemQualityChar.SetRange("RSMUS QM Sales Code", '');
                    if lItemQualityChar.FindFirst()then begin
                        if(TempQualMgmtTestLog."RSMUS QM Type" = TempQualMgmtTestLog."RSMUS QM Type"::Decimal) OR (TempQualMgmtTestLog."RSMUS QM Type" = TempQualMgmtTestLog."RSMUS QM Type"::Date)then COASpecification:=Format(lItemQualityChar.RSMUSCOALowerLimit) + ' - ' + Format(lItemQualityChar.RSMUSCOAUpperLimit)
                        else
                            COASpecification:=lItemQualityChar.RSMUSCOANominalValue;
                    end;
                end;
                Clear(gTester);
                gTester:=TempQualMgmtTestLog."RSMUS QM Tester Name";
                gQualityDescription:='';
                if lQMQualityChar.Get(TempQualMgmtTestLog."RSMUS QM Quality Char. Code")then begin
                    gQualityDescription:=lQMQualityChar."RSMUS QM Description";
                end;
                if gQualityDescription = '' then gQualityDescription:=TempQualMgmtTestLog."RSMUS QM Quality Char. Code";
                gTestMethDescription:='';
                if lQMTestMethod.Get(TempQualMgmtTestLog."RSMUS QM Test Method")then begin
                    gTestMethDescription:=lQMTestMethod."RSMUS QM Description";
                end;
                if gQualityDescription = '' then gTestMethDescription:=TempQualMgmtTestLog."RSMUS QM Test Method";
            end;
            trigger OnPreDataItem()
            begin
                RecCnt:=TempQualMgmtTestLog.Count();
                if RecCnt = 0 then Error('No characteristics in the log are set to print on Certificate of Analysis.');
                SetRange(Number, 1, RecCnt);
                OnLineNo:=0;
            end;
        }
    }
    requestpage
    {
        SaveValues = True;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field("Print Company Address"; PrintCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Company';
                        ToolTip = 'Print Company';
                    }
                    field(gWhseShpmntNo; gWhseShpmntNo)
                    {
                        Caption = 'Warehouse Shipment No.';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean var
                            WhseShpmntLine: Record "Warehouse Shipment Line";
                            WhseShpmntLinePg: Page "Whse. Shipment Lines";
                        begin
                            WhseShpmntLine.SetRange("Item No.", gItem);
                            WhseShpmntLinePg.SetTableView(WhseShpmntLine);
                            WhseShpmntLinePg.LOOKUPMODE(TRUE);
                            if WhseShpmntLinePg.RunModal() = ACTION::LookupOK then begin
                                WhseShpmntLinePg.GetRecord(WhseShpmntLine);
                                gWhseShpmntNo:=WhseShpmntLine."No.";
                                gWhseShipmentLineNo:=WhseShpmntLine."Line No.";
                            end;
                        end;
                    }
                    field(gWhseShipmentLineNo; gWhseShipmentLineNo)
                    {
                        Caption = 'Warehouse Shipment Line No.';
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(gBatch; gBatch)
                    {
                        Caption = 'Batch';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean var
                            lItemUOM: Record "Item Unit of Measure";
                            lItemUOMPg: Page "Item Units of Measure";
                        begin
                            lItemUOM.SetRange("Item No.", gItem);
                            lItemUOMPg.SetTableView(lItemUOM);
                            lItemUOMPg.LOOKUPMODE(TRUE);
                            if lItemUOMPg.RunModal() = ACTION::LookupOK then begin
                                lItemUOMPg.GetRecord(lItemUOM);
                                gBatch:=lItemUOM."Code";
                            end;
                        end;
                    }
                    field(gBatchSizeShipped; gBatchSizeShipped)
                    {
                        Caption = 'Batch Size Shipped';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean var
                            lItemUOM: Record "Item Unit of Measure";
                            lItemUOMPg: Page "Item Units of Measure";
                        begin
                            lItemUOM.SetRange("Item No.", gItem);
                            lItemUOMPg.SetTableView(lItemUOM);
                            lItemUOMPg.LOOKUPMODE(TRUE);
                            if lItemUOMPg.RunModal() = ACTION::LookupOK then begin
                                lItemUOMPg.GetRecord(lItemUOM);
                                gBatchSizeShipped:=lItemUOM."Code";
                            end;
                        end;
                    }
                    field(PrintQuantities; PrintQuantities)
                    {
                        Caption = 'Print Quantities on CoA';
                        ApplicationArea = All;
                    }
                }
            }
        }
        trigger OnOpenPage()
        var
            QualLog: Record "RSMUS QM Qual Mgmt Test Log";
        begin
            Clear(gItem);
            PrintCompany:=True;
            if TestLog.GetFilters() = '' then if QualLog.findlast()then begin
                    TestLog.setrange("RSMUS QM Item No.", QualLog."RSMUS QM Item No.");
                    TestLog.setrange("RSMUS QM Lot No.", QualLog."RSMUS QM Lot No.");
                    gItem:=QualLog."RSMUS QM Item No.";
                end;
        end;
    }
    labels
    {
    LblTitle='Certificate of Analysis';
    LblItem='Item No.';
    LblLot='Lot No.';
    LblChar='Quality Characteristic';
    LblLower='Lower Limit';
    LblUpper='Upper Limit';
    LblNominal='Nominal Value';
    LblActual='Actual Result';
    LblTest='Test Method';
    LblDesc='Description';
    LblExpDate='Expiration Date:';
    LblTestDate='Test Date';
    LblTestTime='Test Time';
    LblSigned='Quality Manager:';
    LblDate='Date:';
    }
    trigger OnInitReport()
    begin
        RSMUSCompanyInfo.Get();
        RSMUSCompanyInfo.CalcFields(Picture);
        QualityMgmtSetup.Get();
        gBatch:=QualityMgmtSetup.RSMUSDefaultBatchUOM;
        gBatchSizeShipped:=QualityMgmtSetup.RSMUSDefaultShippedBatchUOM;
    end;
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        QualityMgmtSetup.Get();
        CompanyInformation.CalcFields(Picture);
        case QualityMgmtSetup."RSMUS QM Logo Position on Docs" of QualityMgmtSetup."RSMUS QM Logo Position on Docs"::"No Logo": ;
        QualityMgmtSetup."RSMUS QM Logo Position on Docs"::Left: begin
            CompanyInformation1.Get();
            CompanyInformation1.CalcFields(Picture);
        end;
        QualityMgmtSetup."RSMUS QM Logo Position on Docs"::Center: begin
            CompanyInformation2.Get();
            CompanyInformation2.CalcFields(Picture);
        end;
        QualityMgmtSetup."RSMUS QM Logo Position on Docs"::Right: begin
            CompanyInformation3.Get();
            CompanyInformation3.CalcFields(Picture);
        end;
        end;
        if PrintCompany then CustomFunctionsQualityManagement.Company2(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
        gCompanyDetails:='Tel ' + CompanyInformation."Phone No." + ' Fax ' + CompanyInformation."Fax No." + ' ' + CompanyInformation."Home Page";
        NIFNoBlank:=true;
        gVariantCodeBlank:=true;
    end;
    var RSMUSCompanyInfo: Record "Company Information";
    CompanyInformation: Record "Company Information";
    TempQualMgmtTestLog: Record "RSMUS QM Qual Mgmt Test Log" temporary;
    CompanyInformation1: Record "Company Information";
    CompanyInformation2: Record "Company Information";
    CompanyInformation3: Record "Company Information";
    QualityMgmtSetup: Record "RSMUS QM Quality Mgmt Setup";
    Item: Record Item;
    gCustomer: Record Customer;
    gSO: Record "Sales Header";
    QualityChar: Record "RSMUS QM Quality Char.";
    TestMethod: Record "RSMUS QM Test Method";
    WhseShpmntHeader: Record "Warehouse Shipment Header";
    gQMSetup: Record "RSMUS QM Quality Mgmt Setup";
    CustomFunctionsQualityManagement: Codeunit "RSMUS QM Quality Management";
    //CharCode1: Code[10];
    RecCnt: Integer;
    OnLineNo: Integer;
    PrintCompany: Boolean;
    CompanyAddress: array[12]of Text[50];
    ItemDesc: Text[100];
    QualityCharDesc: Text[30];
    TestMethDesc: Text[30];
    gItem: Code[20];
    gWhseShpmntNo: Code[20];
    gAddress: Text;
    gCompanyDetails: Text;
    gCustName: Text;
    gPlantID: Text;
    gCustNo: Code[20];
    gTester: Text;
    gItemRefDesc: Text;
    gProductDesc: Text;
    WhseShpmntQty: Decimal;
    WhseShpmntUOM: Text[11];
    gSpec: Text;
    gCrossRef: Text;
    gSpecDate: Date;
    gShelfLife: DateFormula;
    gManufactureDate: Date;
    gExpirationDate: Date;
    gBatch: Code[20];
    gBatchSizeShipped: Code[20];
    NIFNoBlank: Boolean;
    COASpecification: Text;
    RSMUSBatchQuantityDec: Decimal;
    RSMUSBatchSizeQuantityDec: Decimal;
    RSMUSBatchQuantityDenom: Decimal;
    RSMUSBatchQuantity: Text;
    RSMUSBatchSizeQuantity: Text;
    PrintQuantities: Boolean;
    gWhseShipmentLineNo: Integer;
    gVariantCode: Code[10];
    gVariantCodeBlank: Boolean;
    gTesterName: Text[100];
    gQualityDescription: Text[30];
    gTestMethDescription: Text[30];
    gRSMUSItemNo: Code[20];
    local procedure getLocationAddress(WhseShpmntNo: Code[20]): Text var
        lWhseShpmnt: Record "Warehouse Shipment Header";
        lLocation: Record Location;
        lAddress: Text;
    begin
        if lWhseShpmnt.Get(WhseShpmntNo)then If lLocation.Get(lWhseShpmnt."Location Code")then If lLocation."Address 2" <> '' then lAddress:=lLocation.Address + ', ' + lLocation."Address 2" + ', ' + lLocation.City + ' ' + lLocation.County + ' ' + lLocation."Post Code"
                else
                    lAddress:=lLocation.Address + ', ' + lLocation.City + ' ' + lLocation.County + ' ' + lLocation."Post Code";
        exit(lAddress);
    end;
}

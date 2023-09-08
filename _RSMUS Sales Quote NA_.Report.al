report 50102 "RSMUS Sales Quote NA"
{
    //based off of report 10076
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layouts/Rep50102.RSMUSSalesQuoteNA.rdl';
    Caption = 'Sales - Quote';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=CONST(Quote));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Order';

            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(RSMUSShipment_Method_Code; "Shipment Method Code")
            {
            }
            column(RSMUSShipmentMethodDescription; RSMUSShipmentMethodDescription)
            {
            }
            column(RSMUSShipping_Agent_Code; "Shipping Agent Code")
            {
            }
            column(RSMUSShippingAgentName; RSMUSShippingAgentName)
            {
            }
            column(RSMUSShipping_Agent_Service_Code; "Shipping Agent Service Code")
            {
            }
            column(RSMUSShippingAgentServiceDescription; RSMUSShippingAgentServiceDescription)
            {
            }
            column(RSMUSCompanyPic; gCompany.Picture)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No."=FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")WHERE("Document Type"=CONST(Quote));

                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No."=FIELD("Document No."), "Document Line No."=FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")WHERE("Document Type"=CONST(Quote), "Print On Quote"=CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        TempSalesLine.Init();
                        TempSalesLine."Document Type":="Sales Header"."Document Type";
                        TempSalesLine."Document No.":="Sales Header"."No.";
                        TempSalesLine."Line No.":=HighestLineNo + 10;
                        HighestLineNo:=TempSalesLine."Line No.";
                        if StrLen(Comment) <= MaxStrLen(TempSalesLine.Description)then begin
                            TempSalesLine.Description:=Comment;
                            TempSalesLine."Description 2":='';
                        end
                        else
                        begin
                            SpacePointer:=MaxStrLen(TempSalesLine.Description) + 1;
                            while(SpacePointer > 1) and (Comment[SpacePointer] <> ' ')do SpacePointer:=SpacePointer - 1;
                            if SpacePointer = 1 then SpacePointer:=MaxStrLen(TempSalesLine.Description) + 1;
                            TempSalesLine.Description:=CopyStr(Comment, 1, SpacePointer - 1);
                            TempSalesLine."Description 2":=CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesLine."Description 2"));
                        end;
                        TempSalesLine.Insert();
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    TempSalesLine:="Sales Line";
                    TempSalesLine.Insert();
                    HighestLineNo:="Line No.";
                    if("Sales Header"."Tax Area Code" <> '') and not UseExternalTaxEngine then SalesTaxCalc.AddSalesLine(TempSalesLine);
                end;
                trigger OnPostDataItem()
                begin
                    if "Sales Header"."Tax Area Code" <> '' then begin
                        if UseExternalTaxEngine then SalesTaxCalc.CallExternalTaxEngineForSales("Sales Header", true)
                        else
                            SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                        SalesTaxCalc.DistTaxOverSalesLines(TempSalesLine);
                        SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                        BrkIdx:=0;
                        PrevPrintOrder:=0;
                        PrevTaxPercent:=0;
                        TempSalesTaxAmtLine.Reset();
                        TempSalesTaxAmtLine.SetCurrentKey(TempSalesTaxAmtLine."Print Order", TempSalesTaxAmtLine."Tax Area Code for Key", TempSalesTaxAmtLine."Tax Jurisdiction Code");
                        if TempSalesTaxAmtLine.Find('-')then repeat if(TempSalesTaxAmtLine."Print Order" = 0) or (TempSalesTaxAmtLine."Print Order" <> PrevPrintOrder) or (TempSalesTaxAmtLine."Tax %" <> PrevTaxPercent)then begin
                                    BrkIdx:=BrkIdx + 1;
                                    if BrkIdx > 1 then begin
                                        if TaxArea."Country/Region" = TaxArea."Country/Region"::CA then BreakdownTitle:=Text006
                                        else
                                            BreakdownTitle:=Text003;
                                    end;
                                    if BrkIdx > ArrayLen(BreakdownAmt)then begin
                                        BrkIdx:=BrkIdx - 1;
                                        BreakdownLabel[BrkIdx]:=Text004;
                                    end
                                    else
                                        BreakdownLabel[BrkIdx]:=StrSubstNo(TempSalesTaxAmtLine."Print Description", TempSalesTaxAmtLine."Tax %");
                                end;
                                BreakdownAmt[BrkIdx]:=BreakdownAmt[BrkIdx] + TempSalesTaxAmtLine."Tax Amount";
                            until TempSalesTaxAmtLine.Next() = 0;
                        if BrkIdx = 1 then begin
                            Clear(BreakdownLabel);
                            Clear(BreakdownAmt);
                        end;
                    end;
                end;
                trigger OnPreDataItem()
                begin
                    TempSalesLine.Reset();
                    TempSalesLine.DeleteAll();
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No."=FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")WHERE("Document Type"=CONST(Quote), "Print On Quote"=CONST(true), "Document Line No."=CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesLine.Init();
                    TempSalesLine."Document Type":="Sales Header"."Document Type";
                    TempSalesLine."Document No.":="Sales Header"."No.";
                    TempSalesLine."Line No.":=HighestLineNo + 1000;
                    HighestLineNo:=TempSalesLine."Line No.";
                    if StrLen(Comment) <= MaxStrLen(TempSalesLine.Description)then begin
                        TempSalesLine.Description:=Comment;
                        TempSalesLine."Description 2":='';
                    end
                    else
                    begin
                        SpacePointer:=MaxStrLen(TempSalesLine.Description) + 1;
                        while(SpacePointer > 1) and (Comment[SpacePointer] <> ' ')do SpacePointer:=SpacePointer - 1;
                        if SpacePointer = 1 then SpacePointer:=MaxStrLen(TempSalesLine.Description) + 1;
                        TempSalesLine.Description:=CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesLine."Description 2":=CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesLine."Description 2"));
                    end;
                    TempSalesLine.Insert();
                end;
                trigger OnPreDataItem()
                begin
                    TempSalesLine.Init();
                    TempSalesLine."Document Type":="Sales Header"."Document Type";
                    TempSalesLine."Document No.":="Sales Header"."No.";
                    TempSalesLine."Line No.":=HighestLineNo + 1000;
                    HighestLineNo:=TempSalesLine."Line No.";
                    TempSalesLine.Insert();
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(LocationAddress1; LocationAddress[1])
                    {
                    }
                    column(LocationAddress2; LocationAddress[2])
                    {
                    }
                    column(LocationAddress3; LocationAddress[3])
                    {
                    }
                    column(LocationAddress4; LocationAddress[4])
                    {
                    }
                    column(LocationAddress5; LocationAddress[5])
                    {
                    }
                    column(LocationAddress6; LocationAddress[6])
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo3.Picture)
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
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress1; BillToAddress[1])
                    {
                    }
                    column(BillToAddress2; BillToAddress[2])
                    {
                    }
                    column(BillToAddress3; BillToAddress[3])
                    {
                    }
                    column(BillToAddress4; BillToAddress[4])
                    {
                    }
                    column(BillToAddress5; BillToAddress[5])
                    {
                    }
                    column(BillToAddress6; BillToAddress[6])
                    {
                    }
                    column(BillToAddress7; BillToAddress[7])
                    {
                    }
                    column(ShipToAddress1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddress[7])
                    {
                    }
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(OrderDate_SalesHeader; Format("Sales Header"."Order Date", 0, '<Month,2>/<Day,2>/<Year4>'))
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress8; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(PrintFooter; PrintFooter)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(CustTaxIdentificationType; Format(Cust."Tax Identification Type"))
                    {
                    }
                    column(SellCaption; SellCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(SalesQuoteCaption; SalesQuoteCaptionLbl)
                    {
                    }
                    column(SalesQuoteNumberCaption; SalesQuoteNumberCaptionLbl)
                    {
                    }
                    column(SalesQuoteDateCaption; SalesQuoteDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    dataitem(SalesLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(Number_IntegerLine; Number)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(RSMUSItem_Reference_No_; TempSalesLine."Item Reference No.")
                        {
                        }
                        column(RSMUS_Packaging; TempSalesLine."RSMUS Packaging")
                        {
                        }
                        column(TempSalesLineNo; TempSalesLine."No.")
                        {
                        }
                        column(TempSalesLineUOM; TempSalesLine."Unit of Measure Code")
                        {
                        }
                        column(TempSalesLineQuantity; TempSalesLine.Quantity)
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                        DecimalPlaces = 2: 5;
                        }
                        column(TempSalesLineDescription; TempSalesLine.Description + ' ' + TempSalesLine."Description 2")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesLineLineAmtTaxLiable; TempSalesLine."Line Amount" - TaxLiable)
                        {
                        }
                        column(TempSalesLineInvDiscAmt; TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                        }
                        column(TempSalesLineLineAmtTaxAmtInvDiscAmt; TempSalesLine."Line Amount" + TaxAmount - TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(ItemNoCaption; ItemNoCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(TotalPriceCaption; TotalPriceCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(InvoiceDiscountCaption; InvoiceDiscountCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(AmtSubjecttoSalesTaxCptn; AmtSubjecttoSalesTaxCptnLbl)
                        {
                        }
                        column(AmtExemptfromSalesTaxCptn; AmtExemptfromSalesTaxCptnLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber:=OnLineNumber + 1;
                            if OnLineNumber = 1 then TempSalesLine.Find('-')
                            else
                                TempSalesLine.Next();
                            if TempSalesLine.Type = TempSalesLine.Type::" " then begin
                                TempSalesLine."No.":='';
                                TempSalesLine."Unit of Measure":='';
                                TempSalesLine."Line Amount":=0;
                                TempSalesLine."Inv. Discount Amount":=0;
                                TempSalesLine.Quantity:=0;
                            end
                            else if TempSalesLine.Type = TempSalesLine.Type::"G/L Account" then TempSalesLine."No.":='';
                            if TempSalesLine."Tax Area Code" <> '' then TaxAmount:=TempSalesLine."Amount Including VAT" - TempSalesLine.Amount
                            else
                                TaxAmount:=0;
                            if TaxAmount <> 0 then TaxLiable:=TempSalesLine.Amount
                            else
                                TaxLiable:=0;
                            OnAfterCalculateSalesTax("Sales Header", TempSalesLine, TaxAmount, TaxLiable);
                            AmountExclInvDisc:=TempSalesLine."Line Amount";
                            if TempSalesLine.Quantity = 0 then UnitPriceToPrint:=0
                            // so it won't print
                            else
                                UnitPriceToPrint:=Round(AmountExclInvDisc / TempSalesLine.Quantity, 0.00001);
                            if OnLineNumber = NumberOfLines then PrintFooter:=true;
                        end;
                        trigger OnPreDataItem()
                        begin
                            Clear(TaxLiable);
                            Clear(TaxAmount);
                            Clear(AmountExclInvDisc);
                            TempSalesLine.Reset();
                            NumberOfLines:=TempSalesLine.Count();
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber:=0;
                            PrintFooter:=false;
                        end;
                    }
                    trigger OnAfterGetRecord()
                    var
                        Location: Record Location;
                    begin
                        if Location.Get("Sales Header"."Location Code")then begin
                            FormatAddress.FormatAddr(LocationAddress, Location.Name, Location."Name 2", '', Location.Address, Location."Address 2", Location.City, Location."Post Code", Location.County, Location."Country/Region Code");
                        end;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then SalesPrinted.Run("Sales Header");
                        CurrReport.Break();
                    end;
                    CopyNo:=CopyNo + 1;
                    if CopyNo = 1 then // Original
 Clear(CopyTxt)
                    else
                        CopyTxt:=Text000;
                end;
                trigger OnPreDataItem()
                begin
                    NoLoops:=1 + Abs(NoCopies);
                    if NoLoops <= 0 then NoLoops:=1;
                    CopyNo:=0;
                end;
            }
            trigger OnAfterGetRecord()
            var
                ShipmentMethod: Record "Shipment Method";
                ShippingAgent: Record "Shipping Agent";
                ShippingAgentServices: Record "Shipping Agent Services";
            begin
                if PrintCompany then if RespCenter.Get("Responsibility Center")then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No.":=RespCenter."Phone No.";
                        CompanyInformation."Fax No.":=RespCenter."Fax No.";
                    end;
                CurrReport.Language:=Language.GetLanguageIdOrDefault("Language Code");
                FormatDocumentFields("Sales Header");
                if not Cust.Get("Sell-to Customer No.")then Clear(Cust);
                RSMUSSalesHeaderSellTo(BillToAddress, "Sales Header");
                RSMUSSalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header");
                if gCompany.Get()then gCompany.CalcFields(Picture);
                if not CurrReport.Preview then begin
                    if ArchiveDocument then ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);
                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then SegManagement.LogDocument(1, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            SegManagement.LogDocument(1, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    end;
                end;
                Clear(BreakdownTitle);
                Clear(BreakdownLabel);
                Clear(BreakdownAmt);
                TotalTaxLabel:=Text008;
                TaxRegNo:='';
                TaxRegLabel:='';
                if "Tax Area Code" <> '' then begin
                    TaxArea.Get("Tax Area Code");
                    case TaxArea."Country/Region" of TaxArea."Country/Region"::US: TotalTaxLabel:=Text005;
                    TaxArea."Country/Region"::CA: begin
                        TotalTaxLabel:=Text007;
                        TaxRegNo:=CompanyInformation."VAT Registration No.";
                        TaxRegLabel:=CompanyInformation.FieldCaption("VAT Registration No.");
                    end;
                    end;
                    UseExternalTaxEngine:=TaxArea."Use External Tax Engine";
                    SalesTaxCalc.StartSalesTaxCalculation();
                end;
                UseDate:=WorkDate();
                if ShipmentMethod.Get("Sales Header"."Shipment Method Code")then RSMUSShipmentMethodDescription:=ShipmentMethod.Description;
                if ShippingAgent.Get("Sales Header"."Shipping Agent Code")then RSMUSShippingAgentName:=ShippingAgent.Name;
                if ShippingAgentServices.Get("Sales Header"."Shipping Agent Code", "Sales Header"."Shipping Agent Service Code")then RSMUSShippingAgentServiceDescription:=ShippingAgentServices.Description;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoCopies; NoCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Number of Copies';
                        ToolTip = 'Specifies the number of copies of each document (in addition to the original) that you want to print.';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Company Address';
                        ToolTip = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;
                        ToolTip = 'Specifies if the document is archived after you preview or print it.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then LogInteraction:=false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';

                        trigger OnValidate()
                        begin
                            if LogInteraction then ArchiveDocument:=ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable:=true;
            ArchiveDocumentEnable:=true;
        end;
        trigger OnOpenPage()
        begin
            ArchiveDocument:=(SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Question) or (SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Always);
            LogInteraction:=SegManagement.FindInteractTmplCode(1) <> '';
            ArchiveDocumentEnable:=ArchiveDocument;
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        SalesSetup.Get();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        if PrintCompany then FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
    end;
    var ShipmentMethod: Record "Shipment Method";
    gCompany: Record "Company Information";
    PaymentTerms: Record "Payment Terms";
    SalesPurchPerson: Record "Salesperson/Purchaser";
    CompanyInformation: Record "Company Information";
    CompanyInfo1: Record "Company Information";
    CompanyInfo2: Record "Company Information";
    CompanyInfo3: Record "Company Information";
    CompanyInfo: Record "Company Information";
    SalesSetup: Record "Sales & Receivables Setup";
    TempSalesLine: Record "Sales Line" temporary;
    RespCenter: Record "Responsibility Center";
    TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
    TaxArea: Record "Tax Area";
    Cust: Record Customer;
    Language: Codeunit Language;
    SalesPrinted: Codeunit "Sales-Printed";
    FormatAddress: Codeunit "Format Address";
    FormatDocument: Codeunit "Format Document";
    SalesTaxCalc: Codeunit "Sales Tax Calculate";
    ArchiveManagement: Codeunit ArchiveManagement;
    SegManagement: Codeunit SegManagement;
    CompanyAddress: array[8]of Text[100];
    BillToAddress: array[8]of Text[100];
    ShipToAddress: array[8]of Text[100];
    CopyTxt: Text;
    SalespersonText: Text[50];
    PrintCompany: Boolean;
    PrintFooter: Boolean;
    NoCopies: Integer;
    NoLoops: Integer;
    CopyNo: Integer;
    NumberOfLines: Integer;
    OnLineNumber: Integer;
    HighestLineNo: Integer;
    SpacePointer: Integer;
    TaxAmount: Decimal;
    TaxLiable: Decimal;
    UnitPriceToPrint: Decimal;
    AmountExclInvDisc: Decimal;
    ArchiveDocument: Boolean;
    LogInteraction: Boolean;
    Text000: Label 'COPY';
    TaxRegNo: Text;
    TaxRegLabel: Text;
    TotalTaxLabel: Text;
    BreakdownTitle: Text;
    BreakdownLabel: array[4]of Text;
    BreakdownAmt: array[4]of Decimal;
    BrkIdx: Integer;
    PrevPrintOrder: Integer;
    PrevTaxPercent: Decimal;
    UseDate: Date;
    Text003: Label 'Sales Tax Breakdown:';
    Text004: Label 'Other Taxes';
    Text005: Label 'Total Sales Tax:';
    Text006: Label 'Tax Breakdown:';
    Text007: Label 'Total Tax:';
    Text008: Label 'Tax:';
    UseExternalTaxEngine: Boolean;
    [InDataSet]
    ArchiveDocumentEnable: Boolean;
    [InDataSet]
    LogInteractionEnable: Boolean;
    SellCaptionLbl: Label 'Sold';
    ToCaptionLbl: Label 'To:';
    CustomerIDCaptionLbl: Label 'Customer ID';
    SalesPersonCaptionLbl: Label 'SalesPerson';
    ShipCaptionLbl: Label 'Ship';
    SalesQuoteCaptionLbl: Label 'Sales Quote';
    SalesQuoteNumberCaptionLbl: Label 'Sales Quote Number:';
    SalesQuoteDateCaptionLbl: Label 'Sales Quote Date:';
    PageCaptionLbl: Label 'Page:';
    ShipViaCaptionLbl: Label 'Ship Via';
    TermsCaptionLbl: Label 'Terms';
    TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
    ItemNoCaptionLbl: Label 'Item No.';
    UnitCaptionLbl: Label 'Unit';
    DescriptionCaptionLbl: Label 'Description';
    QuantityCaptionLbl: Label 'Quantity';
    UnitPriceCaptionLbl: Label 'Unit Price';
    TotalPriceCaptionLbl: Label 'Total Price';
    SubtotalCaptionLbl: Label 'Subtotal:';
    InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
    TotalCaptionLbl: Label 'Total:';
    AmtSubjecttoSalesTaxCptnLbl: Label 'Amount Subject to Sales Tax';
    AmtExemptfromSalesTaxCptnLbl: Label 'Amount Exempt from Sales Tax';
    LocationAddress: array[8]of Text[100];
    RSMUSShipmentMethodDescription: Text[100];
    RSMUSShippingAgentName: Text[50];
    RSMUSShippingAgentServiceDescription: Text[100];
    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesHeader."Salesperson Code", SalespersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
    end;
    procedure RSMUSSalesHeaderSellTo(var AddrArray: array[8]of Text[100]; var SalesHeader: Record "Sales Header")
    begin
        FormatAddress.FormatAddr(AddrArray, SalesHeader."Sell-to Customer Name", '', SalesHeader."Sell-to Contact", SalesHeader."Sell-to Address", SalesHeader."Sell-to Address 2", SalesHeader."Sell-to City", SalesHeader."Sell-to Post Code", SalesHeader."Sell-to County", SalesHeader."Sell-to Country/Region Code");
    end;
    procedure RSMUSSalesHeaderShipTo(var AddrArray: array[8]of Text[100]; CustAddr: array[8]of Text[100]; var SalesHeader: Record "Sales Header")Result: Boolean var
        CountryRegion: Record "Country/Region";
        SellToCountry: Code[50];
        i: Integer;
    begin
        FormatAddress.FormatAddr(AddrArray, SalesHeader."Ship-to Name", '', SalesHeader."Ship-to Contact", SalesHeader."Ship-to Address", SalesHeader."Ship-to Address 2", SalesHeader."Ship-to City", SalesHeader."Ship-to Post Code", SalesHeader."Ship-to County", SalesHeader."Ship-to Country/Region Code");
        if CountryRegion.Get(SalesHeader."Sell-to Country/Region Code")then SellToCountry:=CountryRegion.Name;
        if SalesHeader."Sell-to Customer No." <> SalesHeader."Bill-to Customer No." then exit(true);
        for i:=1 to ArrayLen(AddrArray)do if(AddrArray[i] <> CustAddr[i]) and (AddrArray[i] <> '') and (AddrArray[i] <> SellToCountry)then exit(true);
        exit(false);
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterCalculateSalesTax(var SalesHeaderParm: Record "Sales Header"; var SalesLineParm: Record "Sales Line"; var TaxAmount: Decimal; var TaxLiable: Decimal)
    begin
    end;
}

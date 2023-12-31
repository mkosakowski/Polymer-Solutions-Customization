report 50104 "RSMUSSales Invoice NA"
// 9939- CMH- 8.15.22 BRD-0036 Rep 10074 Custom Report to include new fields and footer for sales invoice
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layouts/Rep50104.RSMUSSalesInvoiceNA.rdl';
    Caption = 'Sales - Invoice';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Invoice';

            column(No_SalesInvHeader; "No.")
            {
            }
            column(RSMUSShipping_Agent_Code; "Shipping Agent Code") //ship via value
            {
            }
            /*  column(RSMUSShipping_Agent_Service_Code; "RSMUSShipping Agent Service Code")//mode value
              { }*/
            column(RSMUSCompanyPic; gCompany.Picture)
            {
            }
            column(RSMUSShipmentMethodDescription; RSMUSShipmentMethodDescription)
            {
            }
            column(RSMUSShippingAgentName; RSMUSShippingAgentName)
            {
            }
            column(RSMUSShippingAgentServiceDescription; RSMUSShippingAgentServiceDescription)
            {
            }
            column(RSMBankName; RSMBankName)
            {
            }
            column(RSMFederalID; CompanyInformation."Federal ID No.")
            {
            }
            column(RemitToLine1; RemitToLine1)
            {
            }
            column(RemitToLine2; RemitToLine2)
            {
            }
            column(RemitToLine3; RemitToLine3)
            {
            }
            column(RemitToLine4; RemitToLine4)
            {
            }
            column(RSMBankAccountNo; RSMBankNo)
            {
            }
            column(RSMPaymentRoutingNo; RSMRouting)
            {
            }
            column(RSMIBAN; RSMIBAN)
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
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No."=FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No."=FIELD("Document No."), "Document Line No."=FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")WHERE("Document Type"=CONST("Posted Invoice"), "Print On Invoice"=CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        TempSalesInvoiceLine.Init();
                        TempSalesInvoiceLine."Document No.":="Sales Invoice Header"."No.";
                        TempSalesInvoiceLine."Line No.":=HighestLineNo + 10;
                        HighestLineNo:=TempSalesInvoiceLine."Line No.";
                        if StrLen(Comment) <= MaxStrLen(TempSalesInvoiceLine.Description)then begin
                            TempSalesInvoiceLine.Description:=Comment;
                            TempSalesInvoiceLine."Description 2":='';
                        end
                        else
                        begin
                            SpacePointer:=MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                            while(SpacePointer > 1) and (Comment[SpacePointer] <> ' ')do SpacePointer:=SpacePointer - 1;
                            if SpacePointer = 1 then SpacePointer:=MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                            TempSalesInvoiceLine.Description:=CopyStr(Comment, 1, SpacePointer - 1);
                            TempSalesInvoiceLine."Description 2":=CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesInvoiceLine."Description 2"));
                        end;
                        TempSalesInvoiceLine.Insert();
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    TempSalesInvoiceLine:="Sales Invoice Line";
                    TempSalesInvoiceLine.Insert();
                    TempSalesInvoiceLineAsm:="Sales Invoice Line";
                    TempSalesInvoiceLineAsm.Insert();
                    HighestLineNo:="Line No.";
                end;
                trigger OnPreDataItem()
                begin
                    TempSalesInvoiceLine.Reset();
                    TempSalesInvoiceLine.DeleteAll();
                    TempSalesInvoiceLineAsm.Reset();
                    TempSalesInvoiceLineAsm.DeleteAll();
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No."=FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")WHERE("Document Type"=CONST("Posted Invoice"), "Print On Invoice"=CONST(true), "Document Line No."=CONST(0));

                column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    TempSalesInvoiceLine.Init;
                    TempSalesInvoiceLine."Document No.":="Sales Invoice Header"."No.";
                    TempSalesInvoiceLine."Line No.":=HighestLineNo + 1000;
                    HighestLineNo:=TempSalesInvoiceLine."Line No.";
                    if StrLen(Comment) <= MaxStrLen(TempSalesInvoiceLine.Description)then begin
                        TempSalesInvoiceLine.Description:=Comment;
                        TempSalesInvoiceLine."Description 2":='';
                    end
                    else
                    begin
                        SpacePointer:=MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                        while(SpacePointer > 1) and (Comment[SpacePointer] <> ' ')do SpacePointer:=SpacePointer - 1;
                        if SpacePointer = 1 then SpacePointer:=MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                        TempSalesInvoiceLine.Description:=CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesInvoiceLine."Description 2":=CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesInvoiceLine."Description 2"));
                    end;
                    TempSalesInvoiceLine.Insert();
                end;
                trigger OnPreDataItem()
                begin
                    TempSalesInvoiceLine.Init();
                    TempSalesInvoiceLine."Document No.":="Sales Invoice Header"."No.";
                    TempSalesInvoiceLine."Line No.":=HighestLineNo + 1000;
                    HighestLineNo:=TempSalesInvoiceLine."Line No.";
                    TempSalesInvoiceLine.Insert();
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInformationPicture; CompanyInfo3.Picture)
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
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(ShptDate_SalesInvHeader; Format("Sales Invoice Header"."Shipment Date", 0, '<Month,2>/<Day,2>/<Year4>'))
                    {
                    }
                    column(DueDate_SalesInvHeader; Format("Sales Invoice Header"."Due Date", 0, '<Month,2>/<Day,2>/<Year4>'))
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
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
                    column(BilltoCustNo_SalesInvHeader; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(ExtDocNo_SalesInvHeader; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(OrderDate_SalesInvHeader; Format("Sales Invoice Header"."Order Date", 0, '<Month,2>/<Day,2>/<Year4>'))
                    {
                    }
                    column(OrderNo_SalesInvHeader; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(DocumentDate_SalesInvHeader; Format("Sales Invoice Header"."Document Date", 0, '<Month,2>/<Day,2>/<Year4>'))
                    {
                    }
                    column(BillToAddress8; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(DocumentText; DocumentText)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(CustTaxIdentificationType; Format(Cust."Tax Identification Type"))
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(ShipDateCaption; ShipDateCaptionLbl)
                    {
                    }
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(OurOrderNoCaption; OurOrderNoCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(InvoiceNumberCaption; InvoiceNumberCaptionLbl)
                    {
                    }
                    column(InvoiceDateCaption; InvoiceDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    dataitem(SalesInvLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(RSMUSPackaging; TempSalesInvoiceLine."RSMUS Packaging")
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineNo; TempSalesInvoiceLine."No.")
                        {
                        }
                        column(TempSalesInvoiceLineUOM; TempSalesInvoiceLine."Unit of Measure Code")
                        {
                        }
                        column(TempSalesInvoiceLineDesc; TempSalesInvoiceLine.Description)
                        {
                        }
                        column(TempSalesLineRefNo; TempSalesInvoiceLine."Item Reference No.")
                        {
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(TempSalesInvoiceLineQty; TempSalesInvoiceLine.Quantity)
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                        DecimalPlaces = 2: 5;
                        }
                        column(LowDescriptionToPrint; LowDescriptionToPrint)
                        {
                        }
                        column(HighDescriptionToPrint; HighDescriptionToPrint)
                        {
                        }
                        column(TempSalesInvoiceLineDocNo; TempSalesInvoiceLine."Document No.")
                        {
                        }
                        column(TempSalesInvoiceLineLineNo; TempSalesInvoiceLine."Line No.")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtTaxLiable; TempSalesInvoiceLine.Amount - TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtAmtExclInvDisc; TempSalesInvoiceLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVATAmount; TempSalesInvoiceLine."Amount Including VAT" - TempSalesInvoiceLine.Amount)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVAT; TempSalesInvoiceLine."Amount Including VAT")
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(OrderQtyCaption; OrderQtyCaptionLbl)
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
                        column(TotalCaption; TotalCaption)
                        {
                        }
                        column(AmountSubjecttoSalesTaxCaption; AmountSubjecttoSalesTaxCaption)
                        {
                        }
                        column(AmountExemptfromSalesTaxCaption; AmountExemptfromSalesTaxCaption)
                        {
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                            DecimalPlaces = 0: 5;
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent() + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent() + TempPostedAsmLine."No.")
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then TempPostedAsmLine.FindSet
                                else
                                begin
                                    TempPostedAsmLine.Next;
                                    TaxLiable:=0;
                                    AmountExclInvDisc:=0;
                                    TempSalesInvoiceLine.Amount:=0;
                                    TempSalesInvoiceLine."Amount Including VAT":=0;
                                end;
                            end;
                            trigger OnPreDataItem()
                            begin
                                Clear(TempPostedAsmLine);
                                SetRange(Number, 1, TempPostedAsmLine.Count);
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber:=OnLineNumber + 1;
                            if OnLineNumber = 1 then TempSalesInvoiceLine.Find('-')
                            else
                                TempSalesInvoiceLine.Next;
                            OrderedQuantity:=0;
                            if "Sales Invoice Header"."Order No." = '' then OrderedQuantity:=TempSalesInvoiceLine.Quantity
                            else if OrderLine.Get(1, "Sales Invoice Header"."Order No.", TempSalesInvoiceLine."Line No.")then OrderedQuantity:=OrderLine.Quantity
                                else
                                begin
                                    ShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
                                    ShipmentLine.SetRange("Order Line No.", TempSalesInvoiceLine."Line No.");
                                    if ShipmentLine.Find('-')then repeat OrderedQuantity:=OrderedQuantity + ShipmentLine.Quantity;
                                        until 0 = ShipmentLine.Next;
                                end;
                            DescriptionToPrint:=TempSalesInvoiceLine.Description + ' ' + TempSalesInvoiceLine."Description 2";
                            if TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::" " then begin
                                TempSalesInvoiceLine."No.":='';
                                TempSalesInvoiceLine."Unit of Measure":='';
                                TempSalesInvoiceLine.Amount:=0;
                                TempSalesInvoiceLine."Amount Including VAT":=0;
                                TempSalesInvoiceLine."Inv. Discount Amount":=0;
                                TempSalesInvoiceLine.Quantity:=0;
                            end
                            else if TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::"G/L Account" then TempSalesInvoiceLine."No.":='';
                            if TempSalesInvoiceLine."No." = '' then begin
                                HighDescriptionToPrint:=DescriptionToPrint;
                                LowDescriptionToPrint:='';
                            end
                            else
                            begin
                                HighDescriptionToPrint:='';
                                LowDescriptionToPrint:=DescriptionToPrint;
                            end;
                            if TempSalesInvoiceLine.Amount <> TempSalesInvoiceLine."Amount Including VAT" then TaxLiable:=TempSalesInvoiceLine.Amount
                            else
                                TaxLiable:=0;
                            AmountExclInvDisc:=TempSalesInvoiceLine.Amount + TempSalesInvoiceLine."Inv. Discount Amount";
                            if TempSalesInvoiceLine.Quantity = 0 then UnitPriceToPrint:=0
                            // so it won't print
                            else
                                UnitPriceToPrint:=Round(AmountExclInvDisc / TempSalesInvoiceLine.Quantity, 0.00001);
                            CollectAsmInformation(TempSalesInvoiceLine);
                        end;
                        trigger OnPreDataItem()
                        begin
                            Clear(TaxLiable);
                            Clear(AmountExclInvDisc);
                            NumberOfLines:=TempSalesInvoiceLine.Count();
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber:=0;
                        end;
                    }
                    dataitem(LineFee; "Integer")
                    {
                        DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

                        column(LineFeeCaptionLbl; TempLineFeeNoteOnReportHist.ReportText)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if not DisplayAdditionalFeeNote then CurrReport.Break();
                            if Number = 1 then begin
                                if not TempLineFeeNoteOnReportHist.FindSet()then CurrReport.Break end
                            else if TempLineFeeNoteOnReportHist.Next() = 0 then CurrReport.Break();
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then SalesInvPrinted.Run("Sales Invoice Header");
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
                    NoLoops:=1 + Abs(NoCopies) + Customer."Invoice Copies";
                    if NoLoops <= 0 then NoLoops:=1;
                    CopyNo:=0;
                end;
            }
            trigger OnAfterGetRecord()
            var
                ShipmentMethod: Record "Shipment Method";
                ShippingAgent: Record "Shipping Agent";
                ShippingAgentServices: Record "Shipping Agent Services";
                BankInfo: Record "Company Information";
                SalesReceivablesSetup: Record "Sales & Receivables Setup";
            begin
                if SalesReceivablesSetup.Get()then begin
                    RemitToLine1:=SalesReceivablesSetup.RSMUSRemitToName;
                    RemitToLine2:=SalesReceivablesSetup.RSMUSRemitToAddress;
                    if SalesReceivablesSetup.RSMUSRemitToAddress2 <> '' then begin
                        RemitToLine3:=SalesReceivablesSetup.RSMUSRemitToAddress2;
                        RemitToLine4:=SalesReceivablesSetup.RSMUSRemitToCity + ', ' + SalesReceivablesSetup.RSMUSRemitToState + ' ' + SalesReceivablesSetup.RSMUSRemitToZIPCode;
                    end
                    else
                    begin
                        RemitToLine3:=SalesReceivablesSetup.RSMUSRemitToCity + ', ' + SalesReceivablesSetup.RSMUSRemitToState + ' ' + SalesReceivablesSetup.RSMUSRemitToZIPCode;
                        RemitToLine4:='';
                    end;
                end;
                if BankInfo.Get()then begin
                    RSMBankName:=BankInfo."Bank Name";
                    RSMBankNo:=BankInfo."Bank Account No.";
                    RSMIBAN:=BankInfo."SWIFT Code";
                    RSMRouting:=BankInfo."Payment Routing No.";
                end;
                if gCompany.Get()then gCompany.CalcFields(Picture);
                if PrintCompany then if RespCenter.Get("Responsibility Center")then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No.":=RespCenter."Phone No.";
                        CompanyInformation."Fax No.":=RespCenter."Fax No.";
                    end;
                CurrReport.Language:=Language.GetLanguageIdOrDefault("Language Code");
                if "Salesperson Code" = '' then Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                if not Customer.Get("Bill-to Customer No.")then begin
                    Clear(Customer);
                    "Bill-to Name":=Text009;
                    "Ship-to Name":=Text009;
                end;
                DocumentText:=USText000;
                if "Prepayment Invoice" then DocumentText:=USText001;
                RSMUSSalesInvBillTo(BillToAddress, "Sales Invoice Header");
                RSMUSSalesInvShipTo(ShipToAddress, ShipToAddress, "Sales Invoice Header");
                if "Payment Terms Code" = '' then Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalCaption:=StrSubstNo(TotalCaptionTxt, GLSetup."LCY Code");
                    AmountExemptfromSalesTaxCaption:=StrSubstNo(AmountExemptfromSalesTaxCaptionTxt, GLSetup."LCY Code");
                    AmountSubjecttoSalesTaxCaption:=StrSubstNo(AmountSubjecttoSalesTaxCaptionTxt, GLSetup."LCY Code");
                end
                else
                begin
                    TotalCaption:=StrSubstNo(TotalCaptionTxt, "Currency Code");
                    AmountExemptfromSalesTaxCaption:=StrSubstNo(AmountExemptfromSalesTaxCaption, "Currency Code");
                    AmountSubjecttoSalesTaxCaption:=StrSubstNo(AmountSubjecttoSalesTaxCaption, "Currency Code");
                end;
                GetLineFeeNoteOnReportHist("No.");
                if LogInteraction then if not CurrReport.Preview then begin
                        if "Bill-to Contact No." <> '' then SegManagement.LogDocument(4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
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
                    SalesTaxCalc.StartSalesTaxCalculation;
                    if TaxArea."Use External Tax Engine" then SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Invoice Header", 0, "No.")
                    else
                    begin
                        SalesTaxCalc.AddSalesInvoiceLines("No.");
                        SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                    end;
                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                    BrkIdx:=0;
                    PrevPrintOrder:=0;
                    PrevTaxPercent:=0;
                    TempSalesTaxAmtLine.Reset;
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
                if ShipmentMethod.Get("Sales Invoice Header"."Shipment Method Code")then RSMUSShipmentMethodDescription:=ShipmentMethod.Description;
                if ShippingAgent.Get("Sales Invoice Header"."Shipping Agent Code")then RSMUSShippingAgentName:=ShippingAgent.Name;
                if ShippingAgentServices.Get("Sales Invoice Header"."Shipping Agent Code", "Sales Invoice Header".RSMUSShippingAgentServiceCode)then RSMUSShippingAgentServiceDescription:=ShippingAgentServices.Description;
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
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies that you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies if you want notes about additional fees to be shown on the document.';
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
            PrintCompany:=true;
        end;
        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        GLSetup.Get();
    end;
    trigger OnPreReport()
    begin
        ShipmentLine.SetCurrentKey("Order No.", "Order Line No.");
        if not CurrReport.UseRequestPage then InitLogInteraction;
        CompanyInformation.Get();
        SalesSetup.Get();
        case SalesSetup."Logo Position on Documents" of SalesSetup."Logo Position on Documents"::"No Logo": ;
        SalesSetup."Logo Position on Documents"::Left: begin
            CompanyInfo3.Get();
            CompanyInfo3.CalcFields(Picture);
        end;
        SalesSetup."Logo Position on Documents"::Center: begin
            CompanyInfo1.Get();
            CompanyInfo1.CalcFields(Picture);
        end;
        SalesSetup."Logo Position on Documents"::Right: begin
            CompanyInfo2.Get();
            CompanyInfo2.CalcFields(Picture);
        end;
        end;
        if PrintCompany then FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
    end;
    var ShipmentMethod: Record "Shipment Method";
    PaymentTerms: Record "Payment Terms";
    SalesPurchPerson: Record "Salesperson/Purchaser";
    CompanyInformation: Record "Company Information";
    CompanyInfo3: Record "Company Information";
    CompanyInfo1: Record "Company Information";
    CompanyInfo2: Record "Company Information";
    SalesSetup: Record "Sales & Receivables Setup";
    Customer: Record Customer;
    OrderLine: Record "Sales Line";
    ShipmentLine: Record "Sales Shipment Line";
    TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
    TempSalesInvoiceLineAsm: Record "Sales Invoice Line" temporary;
    RespCenter: Record "Responsibility Center";
    TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
    TaxArea: Record "Tax Area";
    Cust: Record Customer;
    TempPostedAsmLine: Record "Posted Assembly Line" temporary;
    TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
    GLSetup: Record "General Ledger Setup";
    gCompany: Record "Company Information";
    Language: Codeunit Language;
    SalesInvPrinted: Codeunit "Sales Inv.-Printed";
    FormatAddress: Codeunit "Format Address";
    SalesTaxCalc: Codeunit "Sales Tax Calculate";
    SegManagement: Codeunit SegManagement;
    CompanyAddress: array[8]of Text[100];
    BillToAddress: array[8]of Text[100];
    ShipToAddress: array[8]of Text[100];
    CopyTxt: Text;
    DescriptionToPrint: Text[210];
    HighDescriptionToPrint: Text[210];
    LowDescriptionToPrint: Text[210];
    PrintCompany: Boolean;
    NoCopies: Integer;
    NoLoops: Integer;
    CopyNo: Integer;
    NumberOfLines: Integer;
    OnLineNumber: Integer;
    HighestLineNo: Integer;
    SpacePointer: Integer;
    LogInteraction: Boolean;
    Text000: Label 'COPY';
    TaxRegNo: Text;
    TaxRegLabel: Text;
    TotalTaxLabel: Text;
    BreakdownTitle: Text;
    BreakdownLabel: array[4]of Text;
    BreakdownAmt: array[4]of Decimal;
    Text003: Label 'Sales Tax Breakdown:';
    Text004: Label 'Other Taxes';
    BrkIdx: Integer;
    PrevPrintOrder: Integer;
    PrevTaxPercent: Decimal;
    Text005: Label 'Total Sales Tax:';
    Text006: Label 'Tax Breakdown:';
    Text007: Label 'Total Tax:';
    Text008: Label 'Tax:';
    Text009: Label 'VOID INVOICE';
    DocumentText: Text[20];
    USText000: Label 'INVOICE';
    USText001: Label 'PREPAYMENT REQUEST';
    [InDataSet]
    LogInteractionEnable: Boolean;
    DisplayAssemblyInformation: Boolean;
    BillCaptionLbl: Label 'Bill';
    ToCaptionLbl: Label 'To:';
    ShipViaCaptionLbl: Label 'Ship Via';
    ShipDateCaptionLbl: Label 'Ship Date';
    DueDateCaptionLbl: Label 'Due Date';
    TermsCaptionLbl: Label 'Terms';
    CustomerIDCaptionLbl: Label 'Customer ID';
    PONumberCaptionLbl: Label 'P.O. Number';
    PODateCaptionLbl: Label 'P.O. Date';
    OurOrderNoCaptionLbl: Label 'Our Order No.';
    SalesPersonCaptionLbl: Label 'SalesPerson';
    ShipCaptionLbl: Label 'Ship';
    InvoiceNumberCaptionLbl: Label 'Invoice Number:';
    InvoiceDateCaptionLbl: Label 'Invoice Date:';
    PageCaptionLbl: Label 'Page:';
    TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
    ItemDescriptionCaptionLbl: Label 'Item/Description';
    UnitCaptionLbl: Label 'Unit';
    OrderQtyCaptionLbl: Label 'Order Qty';
    QuantityCaptionLbl: Label 'Quantity';
    UnitPriceCaptionLbl: Label 'Unit Price';
    TotalPriceCaptionLbl: Label 'Total Price';
    SubtotalCaptionLbl: Label 'Subtotal:';
    InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
    TotalCaptionTxt: Label 'Total %1:';
    AmountSubjecttoSalesTaxCaptionTxt: Label 'Amount Subject to Sales Tax %1';
    AmountExemptfromSalesTaxCaptionTxt: Label 'Amount Exempt from Sales Tax %1';
    TotalCaption: Text;
    AmountSubjecttoSalesTaxCaption: Text;
    AmountExemptfromSalesTaxCaption: Text;
    DisplayAdditionalFeeNote: Boolean;
    RSMBankNo: Text;
    RSMBankName: Text;
    RSMIBAN: Text;
    RSMRouting: Text;
    RemitToLine1: Text;
    RemitToLine2: Text;
    RemitToLine3: Text;
    RemitToLine4: Text;
    RSMUSShipmentMethodDescription: Text[100];
    RSMUSShippingAgentName: Text[50];
    RSMUSShippingAgentServiceDescription: Text[100];
    TaxLiable: Decimal;
    OrderedQuantity: Decimal;
    UnitPriceToPrint: Decimal;
    AmountExclInvDisc: Decimal;
    procedure InitLogInteraction()
    begin
        LogInteraction:=SegManagement.FindInteractTmplCode(4) <> '';
    end;
    procedure CollectAsmInformation(TempSalesInvoiceLine: Record "Sales Invoice Line" temporary)
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        TempPostedAsmLine.DeleteAll();
        if not DisplayAssemblyInformation then exit;
        if not TempSalesInvoiceLineAsm.Get(TempSalesInvoiceLine."Document No.", TempSalesInvoiceLine."Line No.")then exit;
        SalesInvoiceLine.Get(TempSalesInvoiceLineAsm."Document No.", TempSalesInvoiceLineAsm."Line No.");
        if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item then exit;
        ValueEntry.SetCurrentKey(ValueEntry."Document No.");
        ValueEntry.SetRange(ValueEntry."Document No.", SalesInvoiceLine."Document No.");
        ValueEntry.SetRange(ValueEntry."Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetRange(ValueEntry."Document Line No.", SalesInvoiceLine."Line No.");
        ValueEntry.SetRange(ValueEntry."Applies-to Entry", 0);
        if not ValueEntry.FindSet()then exit;
        repeat if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.")then if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then begin
                    SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader)then begin
                        PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                        if PostedAsmLine.FindSet()then repeat TreatAsmLineBuffer(PostedAsmLine);
                            until PostedAsmLine.Next() = 0;
                    end;
                end;
        until ValueEntry.Next() = 0;
    end;
    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        Clear(TempPostedAsmLine);
        TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FindFirst()then begin
            TempPostedAsmLine.Quantity+=PostedAsmLine.Quantity;
            TempPostedAsmLine.Modify();
        end
        else
        begin
            Clear(TempPostedAsmLine);
            TempPostedAsmLine:=PostedAsmLine;
            TempPostedAsmLine.Insert();
        end;
    end;
    procedure GetUOMText(UOMCode: Code[10]): Text[10]var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode)then exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;
    procedure BlanksForIndent(): Text[10]begin
        exit(PadStr('', 2, ' '));
    end;
    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DeleteAll();
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst()then exit;
        if not Customer.Get(CustLedgerEntry."Customer No.")then exit;
        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet()then begin
            repeat TempLineFeeNoteOnReportHist.Init();
                TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.Insert();
            until LineFeeNoteOnReportHist.Next() = 0;
        end
        else
        begin
            LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguageCode);
            if LineFeeNoteOnReportHist.FindSet()then repeat TempLineFeeNoteOnReportHist.Init();
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert();
                until LineFeeNoteOnReportHist.Next() = 0;
        end;
    end;
    procedure RSMUSSalesInvBillTo(var AddrArray: array[8]of Text[100]; var SalesInvHeader: Record "Sales Invoice Header")
    begin
        FormatAddress.FormatAddr(AddrArray, SalesInvHeader."Bill-to Name", '', SalesInvHeader."Bill-to Contact", SalesInvHeader."Bill-to Address", SalesInvHeader."Bill-to Address 2", SalesInvHeader."Bill-to City", SalesInvHeader."Bill-to Post Code", SalesInvHeader."Bill-to County", SalesInvHeader."Bill-to Country/Region Code");
    end;
    procedure RSMUSSalesInvShipTo(var AddrArray: array[8]of Text[100]; CustAddr: array[8]of Text[100]; var SalesInvHeader: Record "Sales Invoice Header")Result: Boolean var
        i: Integer;
    begin
        FormatAddress.FormatAddr(AddrArray, SalesInvHeader."Ship-to Name", '', SalesInvHeader."Ship-to Contact", SalesInvHeader."Ship-to Address", SalesInvHeader."Ship-to Address 2", SalesInvHeader."Ship-to City", SalesInvHeader."Ship-to Post Code", SalesInvHeader."Ship-to County", SalesInvHeader."Ship-to Country/Region Code");
        if SalesInvHeader."Sell-to Customer No." <> SalesInvHeader."Bill-to Customer No." then exit(true);
        for i:=1 to ArrayLen(AddrArray)do if AddrArray[i] <> CustAddr[i]then exit(true);
        exit(false);
    end;
}

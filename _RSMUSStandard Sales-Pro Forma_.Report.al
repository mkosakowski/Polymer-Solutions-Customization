report 50107 "RSMUSStandard Sales-Pro Forma"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layouts/Rep50107.RSMUSProForma.rdl';
    Caption = 'Pro Forma Invoice';

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Pro Forma Invoice';

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
            column(CustNo; "Sell-to Customer No.")
            {
            }
            column(PaymentTerms; "Payment Terms Code")
            {
            }
            column(PaymentTermsDesc; PaymentTerms.Description)
            {
            }
            column(Posting_Date; Format("Posting Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(Posting_No_; "Posting No.")
            {
            }
            column(Shipment_Date; Format("Shipment Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(Due_Date; Format("Due Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(gShipmentMethodDescription; "Shipment Method Code")
            {
            }
            column(RSMUSShipping_Agent_Code; "Shipping Agent Code") //ship via value
            {
            }
            column(RSMUSShipping_Agent_Service_Code; "Shipping Agent Service Code") //mode value
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
            column(RSMUSCompanyPic; gCompany.Picture)
            {
            }
            column(DocumentDate; Format("Document Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(OrderDate; Format("Order Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyEMail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInformation."Home Page")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyVATRegNo; CompanyInformation.GetVATRegistrationNumber())
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
            column(ShipToAddress8; ShipToAddress[8])
            {
            }
            column(CustomerAddress1; CustomerAddress[1])
            {
            }
            column(CustomerAddress2; CustomerAddress[2])
            {
            }
            column(CustomerAddress3; CustomerAddress[3])
            {
            }
            column(CustomerAddress4; CustomerAddress[4])
            {
            }
            column(CustomerAddress5; CustomerAddress[5])
            {
            }
            column(CustomerAddress6; CustomerAddress[6])
            {
            }
            column(CustomerAddress7; CustomerAddress[7])
            {
            }
            column(CustomerAddress8; CustomerAddress[8])
            {
            }
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(CompanyLegalOffice; CompanyInformation.GetLegalOffice())
            {
            }
            column(SalesPersonName; SalespersonPurchaserName)
            {
            }
            column(ShipmentMethodDescription; ShipmentMethodDescription)
            {
            }
            column(Currency; CurrencyCode)
            {
            }
            column(CustomerVATRegNo; GetCustomerVATRegistrationNumber())
            {
            }
            column(CustomerVATRegistrationNoLbl; GetCustomerVATRegistrationNumberLbl())
            {
            }
            column(PageLbl; PageLbl)
            {
            }
            column(DocumentTitleLbl; DocumentCaption())
            {
            }
            column(YourReferenceLbl; FieldCaption("Your Reference"))
            {
            }
            column(ExternalDocumentNoLbl; FieldCaption("External Document No."))
            {
            }
            column(CompanyLegalOfficeLbl; CompanyInformation.GetLegalOfficeLbl())
            {
            }
            column(SalesPersonLbl; SalesPersonLblText)
            {
            }
            column(EMailLbl; CompanyInformation.FieldCaption("E-Mail"))
            {
            }
            column(HomePageLbl; CompanyInformation.FieldCaption("Home Page"))
            {
            }
            column(CompanyPhoneNoLbl; CompanyInformation.FieldCaption("Phone No."))
            {
            }
            column(ShipmentMethodDescriptionLbl; DummyShipmentMethod.TableCaption)
            {
            }
            column(CurrencyLbl; DummyCurrency.TableCaption)
            {
            }
            column(ItemLbl; Item.TableCaption)
            {
            }
            column(TariffLbl; Item.FieldCaption("Tariff No."))
            {
            }
            column(UnitPriceLbl; Item.FieldCaption("Unit Price"))
            {
            }
            column(CountryOfManufactuctureLbl; CountryOfManufactuctureLbl)
            {
            }
            column(AmountLbl; Line.FieldCaption(Amount))
            {
            }
            column(VATPctLbl; Line.FieldCaption("VAT %"))
            {
            }
            column(VATAmountLbl; DummyVATAmountLine.VATAmountText())
            {
            }
            column(TotalWeightLbl; TotalWeightLbl)
            {
            }
            column(TotalAmountLbl; TotalAmountLbl)
            {
            }
            column(TotalAmountInclVATLbl; TotalAmountInclVATLbl)
            {
            }
            column(QuantityLbl; Line.FieldCaption(Quantity))
            {
            }
            column(NetWeightLbl; Line.FieldCaption("Net Weight"))
            {
            }
            column(DeclartionLbl; DeclartionLbl)
            {
            }
            column(SignatureLbl; SignatureLbl)
            {
            }
            column(SignatureNameLbl; SignatureNameLbl)
            {
            }
            column(SignaturePositionLbl; SignaturePositionLbl)
            {
            }
            column(VATRegNoLbl; CompanyInformation.GetVATRegistrationNumberLbl())
            {
            }
            column(RSMUSRequestedDeliveryDate; Format("Requested Delivery Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(Unit; "Unit of Measure Code")
                {
                }
                column(RSMUSPackaging; "RSMUS Packaging")
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
                column(ItemDescription; Description)
                {
                }
                column(CountryOfManufacturing; Item."Country/Region of Origin Code")
                {
                }
                column(Tariff; Item."Tariff No.")
                {
                }
                column(Quantity; "Qty. to Invoice")
                {
                }
                column(RSMUSQuantity; Quantity)
                {
                }
                column(RSMUSDescription; Description)
                {
                }
                column(RSMUSNo; "No.")
                {
                }
                column(RSMUSLineNo; "Line No.")
                {
                }
                column(RSMUSItemRef; "Item Reference No.")
                {
                }
                column(Price; FormattedLinePrice)
                {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 2;
                }
                column(NetWeight; "Net Weight")
                {
                }
                column(LineAmount; FormattedLineAmount)
                {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
                }
                column(VATPct; "VAT %")
                {
                }
                column(VATAmount; FormattedVATAmount)
                {
                }
                column(TaxAmount; "Line Amount" - TaxLiable)
                {
                }
                column(TaxLiable; TaxLiable)
                {
                }
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No."=FIELD("Document No."), "Document Line No."=FIELD("Line No."), "Document Type"=field("Document Type");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")WHERE("Print On Invoice"=CONST(true));

                    column(TempSalesLineNo; TempSalesLine."No.")
                    {
                    }
                    column(TempSalesLineDesc; TempSalesLine.Description + ' ' + TempSalesLine."Description 2")
                    {
                    }
                    column(TempSalesLineDocumentNo; TempSalesLine."Document No.")
                    {
                    }
                    column(TempSalesLineLineNo; TempSalesLine."Line No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        InsertTempLine(Comment, 10)end;
                    trigger OnPreDataItem()
                    begin
                        TempSalesLine.Init();
                        TempSalesLine."Document Type":=Header."Document Type";
                        TempSalesLine."Document No.":=Header."No.";
                        TempSalesLine."Line No.":=HighestLineNo + 1000;
                        HighestLineNo:=TempSalesLine."Line No.";
                        TempSalesLine.Insert();
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                    AutoFormatType: Enum "Auto Format";
                begin
                    TempSalesLine:=Line;
                    TempSalesLine.Insert();
                    TempSalesLineAsm:=Line;
                    TempSalesLineAsm.Insert();
                    HighestLineNo:="Line No.";
                    if gCompany.Get()then begin
                        gCompany.CalcFields(Picture);
                        RSMBankName:=gCompany."Bank Name";
                        RSMBankNo:=gCompany."Bank Account No.";
                        RSMIBAN:=gCompany."SWIFT Code";
                        RSMRouting:=gCompany."Payment Routing No.";
                    end;
                    GetItemForRec("No.");
                    OnBeforeLineOnAfterGetRecord(Header, Line);
                    if IsShipment()then if Location.RequireShipment("Location Code") and ("Quantity Shipped" = 0)then "Qty. to Invoice":=Quantity;
                    if Quantity = 0 then begin
                        LinePrice:="Unit Price";
                        LineAmount:=0;
                        VATAmount:=0;
                    end
                    else
                    begin
                        LinePrice:=Round(Amount / Quantity, Currency."Unit-Amount Rounding Precision");
                        LineAmount:=Round(Amount * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                        VATAmount:=Round(Amount * "VAT %" / 100 * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                        TotalAmount+=LineAmount;
                        TotalWeight+=Round("Qty. to Invoice" * "Net Weight");
                        TotalVATAmount+=VATAmount;
                        TotalAmountInclVAT+=Round("Amount Including VAT" * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                    end;
                    FormattedLinePrice:=Format(LinePrice, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::UnitAmountFormat, CurrencyCode));
                    FormattedLineAmount:=Format(LineAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedVATAmount:=Format(VATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                end;
                trigger OnPreDataItem()
                begin
                    TotalWeight:=0;
                    TotalAmount:=0;
                    TotalVATAmount:=0;
                    TotalAmountInclVAT:=0;
                    SetRange(Type, Type::Item);
                    TempSalesLine.Reset();
                    TempSalesLine.DeleteAll();
                    TempSalesLineAsm.Reset();
                    TempSalesLineAsm.DeleteAll();
                    OnAfterLineOnPreDataItem(Header, Line);
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No."=FIELD("No."), "Document Type"=field("Document Type");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")WHERE("Print On Invoice"=CONST(true), "Document Line No."=CONST(0));

                column(TempSalesLineNoHeader; TempSalesLine."No.")
                {
                }
                column(TempSalesLineDescHeader; TempSalesLine.Description + ' ' + TempSalesLine."Description 2")
                {
                }
                column(TempSalesLineDocumentNoHeader; TempSalesLine."Document No.")
                {
                }
                column(TempSalesLineLineNoHeader; TempSalesLine."Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    InsertTempLine(Comment, 1000);
                end;
                trigger OnPreDataItem()
                begin
                    TempSalesLine.Init();
                    TempSalesLine."Document Type":=Header."Document Type";
                    TempSalesLine."Document No.":=Header."No.";
                    TempSalesLine."Line No.":=HighestLineNo + 1000;
                    HighestLineNo:=TempSalesLine."Line No.";
                    TempSalesLine.Insert();
                end;
            }
            dataitem(Totals; "Integer")
            {
                MaxIteration = 1;

                column(TotalWeight; TotalWeight)
                {
                }
                column(TotalValue; FormattedTotalAmount)
                {
                }
                column(TotalVATAmount; FormattedTotalVATAmount)
                {
                }
                column(TotalAmountInclVAT; FormattedTotalAmountInclVAT)
                {
                }
                column(Discount; Line."Inv. Discount Amount")
                {
                }
                trigger OnPreDataItem()
                var
                    AutoFormatType: Enum "Auto Format";
                begin
                    FormattedTotalAmount:=Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalVATAmount:=Format(TotalVATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalAmountInclVAT:=Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                end;
            }
            trigger OnAfterGetRecord()
            var
                SalesReceivablesSetup: Record "Sales & Receivables Setup";
                ShipmentMethod: Record "Shipment Method";
                ShippingAgent: Record "Shipping Agent";
                ShippingAgentServices: Record "Shipping Agent Services";
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
                if gCompany.Get()then begin
                    gCompany.CalcFields(Picture);
                    RSMBankName:=gCompany."Bank Name";
                    RSMBankNo:=gCompany."Bank Account No.";
                    RSMIBAN:=gCompany.IBAN;
                    RSMRouting:=gCompany."Payment Routing No.";
                end;
                if PaymentTerms.Get("Payment Terms Code")then PaymentTerms1:=PaymentTerms.Description;
                CurrReport.Language:=Language.GetLanguageIdOrDefault("Language Code");
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.")then;
                if BillToContact.Get("Bill-to Contact No.")then;
                TotalAmountInclVAT:=TotalAmountInclVAT - Line."Inv. Discount Amount";
                if ShipmentMethod.Get("Header"."Shipment Method Code")then RSMUSShipmentMethodDescription:=ShipmentMethod.Description;
                if ShippingAgent.Get("Header"."Shipping Agent Code")then RSMUSShippingAgentName:=ShippingAgent.Name;
                if ShippingAgentServices.Get("Header"."Shipping Agent Code", "Header"."Shipping Agent Service Code")then RSMUSShippingAgentServiceDescription:=ShippingAgentServices.Description;
            end;
        }
    }
    trigger OnInitReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
        gCompany.Get();
        gCompany.CalcFields(Picture);
    end;
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        FormatAddress.Company(CompanyAddress, CompanyInformation)end;
    var PaymentTerms: Record "Payment Terms";
    gCompany: Record "Company Information";
    CompanyInformation: Record "Company Information";
    Item: Record Item;
    DummyVATAmountLine: Record "VAT Amount Line";
    DummyShipmentMethod: Record "Shipment Method";
    DummyCurrency: Record Currency;
    Currency: Record Currency;
    SellToContact: Record Contact;
    BillToContact: Record Contact;
    TempSalesLine: Record "Sales Line" temporary;
    TempSalesLineAsm: Record "Sales Line" temporary;
    FormatAddress: Codeunit "Format Address";
    Language: Codeunit Language;
    AutoFormat: Codeunit "Auto Format";
    FormatDocument: Codeunit "Format Document";
    CompanyAddress: array[8]of Text[100];
    PaymentTerms1: Text;
    RSMBankNo: Text;
    RSMBankName: Text;
    RSMIBAN: Text;
    RSMRouting: Text;
    DocumentTitleLbl: Label 'Pro Forma Invoice';
    PageLbl: Label 'Page';
    ShipToAddress: array[8]of Text[100];
    CustomerAddress: array[8]of Text[100];
    SalesPersonLblText: Text[50];
    CountryOfManufactuctureLbl: Label 'Country';
    TotalWeightLbl: Label 'Total Weight';
    SalespersonPurchaserName: Text;
    ShipmentMethodDescription: Text;
    TotalAmountLbl: Text[50];
    TotalAmountInclVATLbl: Text[50];
    FormattedLinePrice: Text;
    FormattedLineAmount: Text;
    FormattedVATAmount: Text;
    FormattedTotalAmount: Text;
    FormattedTotalVATAmount: Text;
    FormattedTotalAmountInclVAT: Text;
    CurrencyCode: Code[10];
    TotalWeight: Decimal;
    TotalAmount: Decimal;
    DeclartionLbl: Label 'For customs purposes only.';
    SignatureLbl: Label 'For and on behalf of the above named company:';
    SignatureNameLbl: Label 'Name (in print) Signature';
    SignaturePositionLbl: Label 'Position in company';
    SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
    SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
    SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
    BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
    BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
    BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
    TotalVATAmount: Decimal;
    TotalAmountInclVAT: Decimal;
    LinePrice: Decimal;
    LineAmount: Decimal;
    VATAmount: Decimal;
    TaxAmount: Decimal;
    TaxLiable: Decimal;
    RemitToLine1: Text;
    RemitToLine2: Text;
    RemitToLine3: Text;
    RemitToLine4: Text;
    RSMUSShipmentMethodDescription: Text[100];
    RSMUSShippingAgentName: Text[50];
    RSMUSShippingAgentServiceDescription: Text[100];
    HighestLineNo: Integer;
    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ResponsibilityCenter: Record "Responsibility Center";
        Customer: Record Customer;
        FormatDocument: Codeunit "Format Document";
        FormatAddress: Codeunit "Format Address";
        TotalAmounExclVATLbl: Text[50];
    begin
        Customer.Get(SalesHeader."Sell-to Customer No.");
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonLblText);
        SalespersonPurchaserName:=SalespersonPurchaser.Name;
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
        ShipmentMethodDescription:=ShipmentMethod.Description;
        FormatAddress.GetCompanyAddr(SalesHeader."Responsibility Center", ResponsibilityCenter, CompanyInformation, ShipToAddress);
        RSMUSSalesHeaderBillTo(CustomerAddress, SalesHeader);
        RSMUSSalesHeaderShipTo(ShipToAddress, ShipToAddress, SalesHeader);
        if SalesHeader."Currency Code" = '' then begin
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("LCY Code");
            CurrencyCode:=GeneralLedgerSetup."LCY Code";
            Currency.InitRoundingPrecision();
        end
        else
        begin
            CurrencyCode:=SalesHeader."Currency Code";
            Currency.Get(SalesHeader."Currency Code");
        end;
        if SalesHeader."Tax Area Code" <> '' then TaxAmount:=SalesHeader."Amount Including VAT" - SalesHeader.Amount
        else
            TaxAmount:=0;
        if TaxAmount <> 0 then TaxLiable:=SalesHeader.Amount
        else
            TaxLiable:=0;
        FormatDocument.SetTotalLabels(SalesHeader."Currency Code", TotalAmountLbl, TotalAmountInclVATLbl, TotalAmounExclVATLbl);
    end;
    local procedure DocumentCaption(): Text var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then exit(DocCaption);
        exit(DocumentTitleLbl);
    end;
    local procedure GetItemForRec(ItemNo: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled:=false;
        OnBeforeGetItemForRec(ItemNo, IsHandled);
        if IsHandled then exit;
        Item.Get(ItemNo);
    end;
    local procedure InsertTempLine(Comment: Text[80]; IncrNo: Integer)
    begin
        TempSalesLine.Init();
        TempSalesLine."Document Type":=Header."Document Type";
        TempSalesLine."Document No.":=Header."No.";
        TempSalesLine."Line No.":=HighestLineNo + IncrNo;
        HighestLineNo:=TempSalesLine."Line No.";
        FormatDocument.ParseComment(Comment, TempSalesLine.Description, TempSalesLine."Description 2");
        TempSalesLine.Insert();
    end;
    procedure RSMUSSalesHeaderSellTo(var AddrArray: array[8]of Text[100]; var SalesHeader: Record "Sales Header")
    begin
        FormatAddress.FormatAddr(AddrArray, SalesHeader."Sell-to Customer Name", '', SalesHeader."Sell-to Contact", SalesHeader."Sell-to Address", SalesHeader."Sell-to Address 2", SalesHeader."Sell-to City", SalesHeader."Sell-to Post Code", SalesHeader."Sell-to County", SalesHeader."Sell-to Country/Region Code");
    end;
    procedure BlanksForIndent(): Text[10]begin
        exit(PadStr('', 2, ' '));
    end;
    procedure RSMUSSalesHeaderBillTo(var AddrArray: array[8]of Text[100]; var SalesHeader: Record "Sales Header")
    var
        Handled: Boolean;
    begin
        FormatAddress.FormatAddr(AddrArray, SalesHeader."Bill-to Name", '', SalesHeader."Bill-to Contact", SalesHeader."Bill-to Address", SalesHeader."Bill-to Address 2", SalesHeader."Bill-to City", SalesHeader."Bill-to Post Code", SalesHeader."Bill-to County", SalesHeader."Bill-to Country/Region Code");
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
    local procedure OnAfterLineOnPreDataItem(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesHeader: Record "Sales Header"; var DocCaption: Text)
    begin
    end;
    [IntegrationEvent(true, false)]
    local procedure OnBeforeGetItemForRec(ItemNo: Code[20]; var IsHandled: Boolean)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;
}

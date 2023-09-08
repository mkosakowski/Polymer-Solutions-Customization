reportextension 50104 "RSMUSWhseShipment" extends "Whse. - Shipment" //7317
{
    //RSM11194 BJK 02/02/23 BRD-0027: Packing Slip
    dataset
    {
        add("Warehouse Shipment Header")
        {
            column(RSMUSCompanyPicture; RSMUSCompanyInformation.Picture)
            {
            }
            column(RSMUSCompanyName; RSMUSCompanyInformation.Name)
            {
            }
            column(RSMUSLocationPhoneNo; RSMUSLocation."Phone No.")
            {
            }
            column(RSMUSCompanyWebsite; RSMUSCompanyInformation."Home Page")
            {
            }
            column(RSMUSWithinUS; RSMUSCompanyInformation.RSMUSEmergencyWithinUS)
            {
            }
            column(RSMUSOutsideUS; RSMUSCompanyInformation.RSMUSEmergencyOutsideUS)
            {
            }
            column(RSMUSEmergencyResponse; RSMUSCompanyInformation.RSMUSEmergencyResponse)
            {
            }
            column(RSMUSAuthorization; RSMUSAuthorizationForReturnText)
            {
            }
            column(RSMUSLocationAddress1; RSMUSLocationAddress[1])
            {
            }
            column(RSMUSLocationAddress2; RSMUSLocationAddress[2])
            {
            }
            column(RSMUSLocationAddress3; RSMUSLocationAddress[3])
            {
            }
            column(RSMUSLocationAddress4; RSMUSLocationAddress[4])
            {
            }
            column(RSMUSLocationAddress5; RSMUSLocationAddress[5])
            {
            }
            column(RSMUSLocationAddress6; RSMUSLocationAddress[6])
            {
            }
            column(RSMUSLocationAddress7; RSMUSLocationAddress[7])
            {
            }
            column(RSMUSLocationAddress8; RSMUSLocationAddress[8])
            {
            }
            column(RSMUSPuller; RSMUSPuller)
            {
            }
            column(RSMUSDate; DT2Date(SystemCreatedAt))
            {
            }
            column(RSMUSPacker; RSMUSPacker)
            {
            }
            column(RSMUSLoader; RSMUSLoader)
            {
            }
            column(RSMUSShippingCertification; RSMUSCompanyInformation.RSMUSShippingCertification)
            {
            }
            column(RSMUSNetWeightTotal; RSMUSNetWeightTotalTxt)
            {
            }
            column(RSMUSGrossWeightTotal; RSMUSGrossWeightTotalTxt)
            {
            }
            column(RSMUSRevisionNo; RSMUSCompanyInformation.RSMUSRevisionNo)
            {
            }
            column(RSMUSFooterText; RSMUSCompanyInformation.RSMUSPackingSlipFooter)
            {
            }
        }
        modify("Warehouse Shipment Header")
        {
        trigger OnAfterAfterGetRecord()
        var
            RSMUSRegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
            RSMUSUser: Record User;
        begin
            CalcFields(RSMUSNetWeightTotal);
            CalcFields(RSMUSGrossWeightTotal);
            if RSMUSNetWeightTotal <> 0 then RSMUSNetWeightTotalTxt:=Format(System.Round(RSMUSNetWeightTotal, 0.01, '=')) + '/LBS'
            else
                RSMUSNetWeightTotalTxt:='';
            if RSMUSGrossWeightTotal <> 0 then RSMUSGrossWeightTotalTxt:=Format(System.Round(RSMUSGrossWeightTotal, 0.01, '=')) + '/LBS'
            else
                RSMUSGrossWeightTotalTxt:='';
            if RSMUSLocation.Get("Warehouse Shipment Header"."Location Code")then begin
                FormatAddress.FormatAddr(RSMUSLocationAddress, '', RSMUSCompanyInformation.Name, '', RSMUSLocation.Address, RSMUSLocation."Address 2", RSMUSLocation.City, RSMUSLocation."Post Code", RSMUSLocation.County, RSMUSLocation."Country/Region Code");
                for RSMUSCount:=1 to 7 do begin
                    if RSMUSLocationAddress[RSMUSCount] = '' then begin
                        RSMUSLocationAddress[RSMUSCount]:=RSMUSLocation."Phone No.";
                        RSMUSLocationAddress[RSMUSCount + 1]:=RSMUSCompanyInformation."Home Page";
                        break;
                    end;
                end;
            end;
            RSMUSAuthorizationForReturnText:='';
            RSMUSAuthorizationForReturnText:=RSMUSCompanyInformation.GetAuthorizationText();
            if RSMUSPuller = '' then begin
                RSMUSRegisteredWhseActivityLine.SetRange("Whse. Document Type", RSMUSRegisteredWhseActivityLine."Whse. Document Type"::Shipment);
                RSMUSRegisteredWhseActivityLine.SetRange("Whse. Document No.", "No.");
                if RSMUSRegisteredWhseActivityLine.FindSet()then repeat Clear(RSMUSUser);
                        if RSMUSUser.Get(RSMUSRegisteredWhseActivityLine.SystemModifiedBy)then begin
                            RSMUSPuller:=RSMUSUser."User Name";
                            break;
                        end;
                    until RSMUSRegisteredWhseActivityLine.Next() = 0;
            end;
        end;
        }
        add("Warehouse Shipment Line")
        {
            column(RSMUSHazardBool; RSMUSHazardBool)
            {
            }
            column(RSMUSWarehouseLineNo; "Line No.")
            {
            }
            column(RSMUSSellToAddress1; RSMUSSellToAddress[1])
            {
            }
            column(RSMUSSellToAddress2; RSMUSSellToAddress[2])
            {
            }
            column(RSMUSSellToAddress3; RSMUSSellToAddress[3])
            {
            }
            column(RSMUSSellToAddress4; RSMUSSellToAddress[4])
            {
            }
            column(RSMUSSellToAddress5; RSMUSSellToAddress[5])
            {
            }
            column(RSMUSSellToAddress6; RSMUSSellToAddress[6])
            {
            }
            column(RSMUSSellToAddress7; RSMUSSellToAddress[7])
            {
            }
            column(RSMUSSellToAddress8; RSMUSSellToAddress[8])
            {
            }
            column(RSMUSSellToPhoneNo; RSMUSSalesHeader."Sell-to Phone No.")
            {
            }
            column(RSMUSShipToAddress1; RSMUSShipToAddress[1])
            {
            }
            column(RSMUSShipToAddress2; RSMUSShipToAddress[2])
            {
            }
            column(RSMUSShipToAddress3; RSMUSShipToAddress[3])
            {
            }
            column(RSMUSShipToAddress4; RSMUSShipToAddress[4])
            {
            }
            column(RSMUSShipToAddress5; RSMUSShipToAddress[5])
            {
            }
            column(RSMUSShipToAddress6; RSMUSShipToAddress[6])
            {
            }
            column(RSMUSShipToAddress7; RSMUSShipToAddress[7])
            {
            }
            column(RSMUSShipToAddress8; RSMUSShipToAddress[8])
            {
            }
            column(RSMUSShipToPhoneNo; RSMUSSalesHeader."Sell-to Phone No.")
            {
            }
            column(RSMUSPONumber; RSMUSSalesHeader."External Document No.")
            {
            }
            column(RSMUSCustNo; RSMUSSalesHeader."Sell-to Customer No.")
            {
            }
            column(RSMUSOrderDate; RSMUSSalesHeader."Order Date")
            {
            }
            column(RSMUSOrderNo; "Warehouse Shipment Line"."Source No.")
            {
            }
            column(RSMUSQuantityShipped; "Warehouse Shipment Line"."Qty. to Ship")
            {
            }
            column(RSMUSQuantityBO; RSMUSQuantityBO)
            {
            }
            column(RSMUSShippingWeightTxt; RSMUSShippingWeightTxt)
            {
            }
            column(RSMUSDateShipped; "Warehouse Shipment Line"."Shipment Date")
            {
            }
            column(RSMUSShippedVia; RSMUSShippingAgentDescription)
            {
            }
            column(RSMUSShipmentService; RSMUSShippingAgentServiceDescription)
            {
            }
            column(RSMUSFreightTerms; RSMUSShipmentMethodDescription)
            {
            }
            column(RSMUSOrderedBy; RSMUSSalesHeader."Sell-to Contact")
            {
            }
            column(RSMUSSalesman; RSMUSSalespersonName)
            {
            }
            column(RSMUSCustomerItemNo; RSMUSSalesLine."Item Reference No.")
            {
            }
            column(RSMUSPackaging; RSMUSSalesLine."RSMUS Packaging")
            {
            }
            column(RSMUSUNNumber; RSMUSSATHazardousDescription)
            {
            }
            column(RSMUSPaymentTermsDescription; RSMUSPaymentTermsDescription)
            {
            }
            column(RSMUSRequestedDeliveryDate; RSMUSSalesHeader."Requested Delivery Date")
            {
            }
        }
        modify("Warehouse Shipment Line")
        {
        trigger OnAfterAfterGetRecord()
        var
            RSMUSHazardItem: Record Item;
            RSMUSSATHazardousMaterial: Record "SAT Hazardous Material";
        begin
            RSMUSHazardBool:=false;
            Clear(RSMUSHazardItem);
            if RSMUSHazardItem.Get("Item No.")then begin
                if RSMUSHazardItem."SAT Hazardous Material" <> '' then RSMUSHazardBool:=true;
            end;
            RSMUSCustomerCommentNum:=0;
            if "Warehouse Shipment Line"."Source Document" = "Warehouse Shipment Line"."Source Document"::"Sales Order" then begin
                if RSMUSSalesHeader.Get(RSMUSSalesHeader."Document Type"::Order, "Warehouse Shipment Line"."Source No.")then begin
                    if RSMUSCustomer.Get(RSMUSSalesHeader."Sell-to Customer No.")then begin
                        RSMUSCustNo:=RSMUSCustomer."No.";
                        RSMUSCommentLine.SetRange("Table Name", RSMUSCommentLine."Table Name"::Customer);
                        RSMUSCommentLine.SetRange("No.", RSMUSCustomer."No.");
                        RSMUSCommentLine.SetRange(RSMUSPrintOnPackingSlip, true);
                        if RSMUSCommentLine.FindSet()then repeat RSMUSCustomerCommentNum+=1;
                            until RSMUSCommentLine.Next() = 0;
                    end;
                    Clear(RSMUSCommentLine);
                    RSMUSSalesHeaderSellTo(RSMUSSellToAddress, RSMUSSalesHeader);
                    RSMUSSalesHeaderShipTo(RSMUSShipToAddress, RSMUSShipToAddress, RSMUSSalesHeader);
                    for RSMUSCount:=1 to 7 do begin
                        if RSMUSSellToAddress[RSMUSCount] = '' then begin
                            if RSMUSSalesHeader."Sell-to Contact" <> '' then begin
                                RSMUSSellToAddress[RSMUSCount]:=RSMUSSalesHeader."Sell-to Contact";
                                RSMUSSellToAddress[RSMUSCount + 1]:=RSMUSSalesHeader."Sell-to Phone No.";
                            end
                            else
                            begin
                                RSMUSSellToAddress[RSMUSCount]:=RSMUSSalesHeader."Sell-to Phone No.";
                                break;
                            end;
                        end;
                    end;
                    if(RSMUSSalesHeader."Ship-to Code" <> '') AND (RSMUSShipToAddressRec.Get(RSMUSSalesHeader."Sell-to Customer No.", RSMUSSalesHeader."Ship-to Code"))then RSMUSShipToPhoneNo:=RSMUSShipToAddressRec."Phone No."
                    else
                        RSMUSShipToPhoneNo:=RSMUSSalesHeader."Sell-to Phone No.";
                    for RSMUSCount:=1 to 7 do begin
                        if RSMUSShipToAddress[RSMUSCount] = '' then begin
                            if RSMUSSalesHeader."Ship-to Contact" <> '' then begin
                                RSMUSShipToAddress[RSMUSCount]:=RSMUSSalesHeader."Ship-to Contact";
                                RSMUSShipToAddress[RSMUSCount + 1]:=RSMUSShipToPhoneNo;
                            end
                            else
                            begin
                                RSMUSShipToAddress[RSMUSCount]:=RSMUSShipToPhoneNo;
                            end;
                            break;
                        end;
                    end;
                    if RSMUSSalespersonPurchaser.Get(RSMUSSalesHeader."Salesperson Code")then RSMUSSalespersonName:=RSMUSSalespersonPurchaser.Name;
                    if RSMUSPaymentTerms.Get(RSMUSSalesHeader."Payment Terms Code")then RSMUSPaymentTermsDescription:=RSMUSPaymentTerms.Description;
                end;
                if RSMUSSalesLine.Get(RSMUSSalesLine."Document Type"::Order, "Warehouse Shipment Line"."Source No.", "Warehouse Shipment Line"."Source Line No.")then begin
                end;
            end;
            if RSMUSItem.Get("Warehouse Shipment Line"."Item No.")then begin
                if RSMUSItem."Gross Weight" <> 0 then begin
                    RSMUSShippingWeight:=RSMUSItem."Gross Weight" * "Warehouse Shipment Line"."Qty. to Ship (Base)";
                    if RSMUSShippingWeight <> 0 then RSMUSShippingWeightTxt:=Format(System.Round(RSMUSShippingWeight, 0.01, '=')) + '/LBS'
                    else
                        RSMUSShippingWeightTxt:='';
                end;
            end;
            if RSMUSShippingAgent.Get("Warehouse Shipment Header"."Shipping Agent Code")then begin
                RSMUSShippingAgentDescription:=RSMUSShippingAgent.Name;
            end;
            if RSMUSShippingAgentServices.Get("Warehouse Shipment Header"."Shipping Agent Code", "Warehouse Shipment Header"."Shipping Agent Service Code")then begin
                RSMUSShippingAgentServiceDescription:=RSMUSShippingAgentServices.Description;
            end;
            if RSMUSShipmentMethod.Get("Warehouse Shipment Header"."Shipment Method Code")then begin
                RSMUSShipmentMethodDescription:=RSMUSShipmentMethod.Description;
            end;
            RSMUSQuantityBO:="Warehouse Shipment Line".Quantity - "Warehouse Shipment Line"."Qty. to Ship";
            if RSMUSSATHazardousMaterial.Get(RSMUSItem."SAT Hazardous Material")then RSMUSSATHazardousDescription:=RSMUSSATHazardousMaterial.Description;
        end;
        }
        addafter("Warehouse Shipment Line")
        {
            dataitem("Warehouse Comment Line"; "Warehouse Comment Line")
            {
                DataItemLink = "No."=FIELD("No.");
                DataItemLinkReference = "Warehouse Shipment Header";

                column(RSMUSLine_No_; "Line No.")
                {
                }
                column(RSMUSComment; Comment)
                {
                }
            }
            dataitem(RSMUSCustomerComments; "Comment Line")
            {
                DataItemTableView = sorting("Line No.")where("Table Name"=filter(Customer), RSMUSPrintOnPackingSlip=const(true));

                column(RSMUSCustomerComment; Comment)
                {
                }
                column(RSMUSCustomerCommentLineNo; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "No." <> RSMUSCustNo then CurrReport.Skip();
                end;
            }
        }
        addlast("Warehouse Shipment Line")
        {
            dataitem("Reservation Entry"; "Reservation Entry")
            {
                DataItemLink = "Source ID"=field("Source No."), "Source Type"=field("Source Type"), "Item No."=field("Item No."), "Source Ref. No."=field("Source Line No.");
                DataItemTableView = where("Lot No."=filter(<>''));

                column(RSMUSLot_No_; "Lot No.")
                {
                }
                column(RSMUSLotQuantity;-"Quantity (Base)")
                {
                }
                // column(RSMUSLotQtyTxt; Format(-Quantity) + "Warehouse Shipment Line"."Unit of Measure Code")
                // { }
                column(RSMUSBaseUOM; RSMUSLotItem."Base Unit of Measure")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if RSMUSLotItem.Get("Reservation Entry"."Item No.")then;
                end;
            }
        }
    }
    rendering
    {
        layout(PSGWhseShipment)
        {
            Caption = 'PSG Whse. Shipment';
            Summary = 'PSG Whse. Shipment';
            Type = RDLC;
            LayoutFile = './src/ReportExt/Layouts/Rep7317-Ext50104.RSMUSWhseShipment.rdl';
        }
    }
    trigger OnPreReport()
    begin
        if RSMUSCompanyInformation.Get()then RSMUSCompanyInformation.CalcFields(Picture);
    end;
    var RSMUSCompanyInformation: Record "Company Information";
    RSMUSSalesHeader: Record "Sales Header";
    RSMUSLocation: Record Location;
    RSMUSItem: Record Item;
    RSMUSLotItem: Record Item;
    RSMUSSalesLine: Record "Sales Line";
    RSMUSShippingAgent: Record "Shipping Agent";
    RSMUSShippingAgentServices: Record "Shipping Agent Services";
    RSMUSShipmentMethod: Record "Shipment Method";
    RSMUSSalespersonPurchaser: Record "Salesperson/Purchaser";
    RSMUSCustomer: Record Customer;
    RSMUSCommentLine: Record "Comment Line";
    RSMUSPaymentTerms: Record "Payment Terms";
    RSMUSShipToAddressRec: Record "Ship-to Address";
    FormatAddress: Codeunit "Format Address";
    RSMUSLocationAddress: array[8]of Text[100];
    RSMUSSellToAddress: array[8]of Text[100];
    RSMUSShipToAddress: array[8]of Text[100];
    RSMUSShippingWeight: Decimal;
    RSMUSShippingWeightTxt: Text[50];
    RSMUSGrossWeightTotalTxt: Text[50];
    RSMUSNetWeightTotalTxt: Text[50];
    RSMUSShippingAgentDescription: Text[50];
    RSMUSShippingAgentServiceDescription: Text[100];
    RSMUSShipmentMethodDescription: Text[100];
    RSMUSSalespersonName: Text[50];
    RSMUSCustomerCommentNum: Integer;
    RSMUSLineNo: Integer;
    RSMUSCustNo: Code[20];
    RSMUSPaymentTermsDescription: Text[100];
    RSMUSHazardBool: Boolean;
    RSMUSCount: Integer;
    RSMUSQuantityBO: Decimal;
    RSMUSAuthorizationForReturnText: Text;
    RSMUSShipToPhoneNo: Text[30];
    RSMUSPuller: Code[50];
    RSMUSSATHazardousDescription: Text[250];
    procedure RSMUSSalesHeaderSellTo(var AddrArray: array[8]of Text[100]; var SalesHeader: Record "Sales Header")
    begin
        FormatAddress.FormatAddr(AddrArray, SalesHeader."Sell-to Customer Name", '', '', SalesHeader."Sell-to Address", SalesHeader."Sell-to Address 2", SalesHeader."Sell-to City", SalesHeader."Sell-to Post Code", SalesHeader."Sell-to County", SalesHeader."Sell-to Country/Region Code");
    end;
    procedure RSMUSSalesHeaderShipTo(var AddrArray: array[8]of Text[100]; CustAddr: array[8]of Text[100]; var SalesHeader: Record "Sales Header")Result: Boolean var
        CountryRegion: Record "Country/Region";
        SellToCountry: Code[50];
        RSMUSi: Integer;
    begin
        FormatAddress.FormatAddr(AddrArray, SalesHeader."Ship-to Name", '', '', SalesHeader."Ship-to Address", SalesHeader."Ship-to Address 2", SalesHeader."Ship-to City", SalesHeader."Ship-to Post Code", SalesHeader."Ship-to County", SalesHeader."Ship-to Country/Region Code");
        if CountryRegion.Get(SalesHeader."Sell-to Country/Region Code")then SellToCountry:=CountryRegion.Name;
        if SalesHeader."Sell-to Customer No." <> SalesHeader."Bill-to Customer No." then exit(true);
        for RSMUSi:=1 to ArrayLen(AddrArray)do if(AddrArray[RSMUSi] <> CustAddr[RSMUSi]) and (AddrArray[RSMUSi] <> '') and (AddrArray[RSMUSi] <> SellToCountry)then exit(true);
        exit(false);
    end;
}

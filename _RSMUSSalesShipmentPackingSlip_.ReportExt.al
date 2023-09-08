reportextension 50105 "RSMUSSalesShipmentPackingSlip" extends "Sales Shipment NA" //10077
{
    //RSM11506 BJK 2023-02-23 BRD-0024: Posted Sales Shipment Packing Slip
    dataset
    {
        add("Sales Shipment Header")
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
            column(RSMUSDate; RSMUSWarehouseShipmentDate)
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
            column(RSMUSHazardBool; RSMUSHazardBool)
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
            column(RSMUSOrderNo; "Order No.")
            {
            }
            column(RSMUSFooterText; RSMUSCompanyInformation.RSMUSPackingSlipFooter)
            {
            }
            column(RSMUSCurrReportPageNoCaption; RSMUSCurrReportPageNoCaptionLbl)
            {
            }
            column(RSMUSRequestedDeliveryDate; "Requested Delivery Date")
            {
            }
        }
        modify("Sales Shipment Header")
        {
        trigger OnAfterAfterGetRecord()
        var
            RSMUSHazardLine: Record "Sales Shipment Line";
            RSMUSHazardItem: Record Item;
            RSMUSRegisteredWhseActivityHdr: Record "Registered Whse. Activity Hdr.";
            RSMUSRegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
            RSMUSPullerWhseShipmentLine: Record "Posted Whse. Shipment Line";
        begin
            CalcFields(RSMUSNetWeightTotal);
            CalcFields(RSMUSGrossWeightTotal);
            if RSMUSNetWeightTotal <> 0 then RSMUSNetWeightTotalTxt:=Format(RSMUSNetWeightTotal) + '/LBS'
            else
                RSMUSNetWeightTotalTxt:='';
            if RSMUSGrossWeightTotal <> 0 then RSMUSGrossWeightTotalTxt:=Format(RSMUSGrossWeightTotal) + '/LBS'
            else
                RSMUSGrossWeightTotalTxt:='';
            if RSMUSLocation.Get("Sales Shipment Header"."Location Code")then begin
                RSMUSFormatAddress.FormatAddr(RSMUSLocationAddress, '', RSMUSCompanyInformation.Name, '', RSMUSLocation.Address, RSMUSLocation."Address 2", RSMUSLocation.City, RSMUSLocation."Post Code", RSMUSLocation.County, RSMUSLocation."Country/Region Code");
                for RSMUSCount:=1 to 7 do begin
                    if RSMUSLocationAddress[RSMUSCount] = '' then begin
                        RSMUSLocationAddress[RSMUSCount]:=RSMUSLocation."Phone No.";
                        RSMUSLocationAddress[RSMUSCount + 1]:=RSMUSCompanyInformation."Home Page";
                        break;
                    end;
                end;
            end;
            RSMUSHazardBool:=false;
            RSMUSHazardLine.SetRange("Document No.", "No.");
            if RSMUSHazardLine.FindSet()then repeat Clear(RSMUSHazardItem);
                    if(RSMUSHazardLine.Type = RSMUSHazardLine.Type::Item) AND (RSMUSHazardItem.Get(RSMUSHazardLine."No."))then begin
                        if RSMUSHazardItem."SAT Hazardous Material" <> '' then RSMUSHazardBool:=true;
                    end;
                until RSMUSHazardLine.Next() = 0;
            RSMUSAuthorizationForReturnText:='';
            RSMUSAuthorizationForReturnText:=RSMUSCompanyInformation.GetAuthorizationText();
            RSMUSPullerWhseShipmentLine.SetRange("Posted Source No.", "Sales Shipment Header"."No.");
            RSMUSPullerWhseShipmentLine.SetRange("Posting Date", "Sales Shipment Header"."Posting Date");
            if(RSMUSPuller = '') AND (RSMUSPullerWhseShipmentLine.FindFirst())then begin
                RSMUSRegisteredWhseActivityLine.SetRange("Whse. Document Type", RSMUSRegisteredWhseActivityLine."Whse. Document Type"::Shipment);
                RSMUSRegisteredWhseActivityLine.SetRange("Whse. Document No.", RSMUSPullerWhseShipmentLine."No.");
                if RSMUSRegisteredWhseActivityLine.FindSet()then repeat Clear(RSMUSRegisteredWhseActivityHdr);
                        if RSMUSRegisteredWhseActivityHdr.Get(RSMUSRegisteredWhseActivityHdr.Type::Pick, RSMUSRegisteredWhseActivityLine."No.") AND (RSMUSRegisteredWhseActivityHdr."Assigned User ID" <> '')then begin
                            //RSMUSPuller := RSMUSRegisteredWhseActivityHdr."Assigned User ID";
                            break;
                        end;
                    until RSMUSRegisteredWhseActivityLine.Next() = 0;
            end;
        end;
        }
        add("Sales Shipment Line")
        {
            column(RSMUSItemNo; "No.")
            {
            }
            column(RSMUSDescription; Description)
            {
            }
            column(RSMUSQuantity; RSMUSPackingSlipQuantity)
            {
            }
            column(RSMUSUOM; "Unit of Measure Code")
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
            column(RSMUSSellToPhoneNo; RSMUSSalesShipmentHeader."Sell-to Phone No.")
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
            column(RSMUSShipToPhoneNo; RSMUSSalesShipmentHeader."Sell-to Phone No.")
            {
            }
            column(RSMUSPONumber; RSMUSSalesShipmentHeader."External Document No.")
            {
            }
            column(RSMUSCustNo; RSMUSSalesShipmentHeader."Sell-to Customer No.")
            {
            }
            column(RSMUSOrderDate; RSMUSSalesShipmentHeader."Order Date")
            {
            }
            column(RSMUSQuantityShipped; "Sales Shipment Line".Quantity)
            {
            }
            column(RSMUSQuantityBO; RSMUSQuantityBO)
            {
            }
            column(RSMUSShippingWeightTxt; RSMUSShippingWeightTxt)
            {
            }
            column(RSMUSDateShipped; "Sales Shipment Line"."Shipment Date")
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
            column(RSMUSOrderedBy; RSMUSSalesShipmentHeader."Sell-to Contact")
            {
            }
            column(RSMUSSalesman; RSMUSSalespersonName)
            {
            }
            column(RSMUSCustomerItemNo; "Sales Shipment Line"."Item Reference No.")
            {
            }
            column(RSMUSPackaging; "Sales Shipment Line"."RSMUS Packaging")
            {
            }
            column(RSMUSUNNumber; RSMUSSATHazardousDescription)
            {
            }
            column(RSMUSPaymentTermsDescription; RSMUSPaymentTermsDescription)
            {
            }
        }
        modify("Sales Shipment Line")
        {
        trigger OnAfterAfterGetRecord()
        var
            RSMUSSATHazardousMaterial: Record "SAT Hazardous Material";
        begin
            RSMUSCustomerCommentNum:=0;
            if RSMUSSalesShipmentHeader.Get("Sales Shipment Line"."Document No.")then begin
                if RSMUSCustomer.Get(RSMUSSalesShipmentHeader."Sell-to Customer No.")then begin
                    RSMUSCustNo:=RSMUSCustomer."No.";
                    RSMUSCommentLine.SetRange("Table Name", RSMUSCommentLine."Table Name"::Customer);
                    RSMUSCommentLine.SetRange("No.", RSMUSCustomer."No.");
                    RSMUSCommentLine.SetRange(RSMUSPrintOnPackingSlip, true);
                    if RSMUSCommentLine.FindSet()then repeat RSMUSCustomerCommentNum+=1;
                        until RSMUSCommentLine.Next() = 0;
                end;
                Clear(RSMUSCommentLine);
                RSMUSSalesHeaderSellTo(RSMUSSellToAddress, RSMUSSalesShipmentHeader);
                RSMUSSalesHeaderShipTo(RSMUSShipToAddress, RSMUSShipToAddress, RSMUSSalesShipmentHeader);
                for RSMUSCount:=1 to 7 do begin
                    if RSMUSSellToAddress[RSMUSCount] = '' then begin
                        if RSMUSSalesShipmentHeader."Sell-to Contact" <> '' then begin
                            RSMUSSellToAddress[RSMUSCount]:=RSMUSSalesShipmentHeader."Sell-to Contact";
                            RSMUSSellToAddress[RSMUSCount + 1]:=RSMUSSalesShipmentHeader."Sell-to Phone No.";
                        end
                        else
                        begin
                            RSMUSSellToAddress[RSMUSCount]:=RSMUSSalesShipmentHeader."Sell-to Phone No.";
                            break;
                        end;
                    end;
                end;
                if(RSMUSSalesShipmentHeader."Ship-to Code" <> '') AND (RSMUSShipToAddressRec.Get(RSMUSSalesShipmentHeader."Sell-to Customer No.", RSMUSSalesShipmentHeader."Ship-to Code"))then RSMUSShipToPhoneNo:=RSMUSShipToAddressRec."Phone No."
                else
                    RSMUSShipToPhoneNo:=RSMUSSalesShipmentHeader."Sell-to Phone No.";
                for RSMUSCount:=1 to 7 do begin
                    if RSMUSShipToAddress[RSMUSCount] = '' then begin
                        if RSMUSSalesShipmentHeader."Ship-to Contact" <> '' then begin
                            RSMUSShipToAddress[RSMUSCount]:=RSMUSSalesShipmentHeader."Ship-to Contact";
                            RSMUSShipToAddress[RSMUSCount + 1]:=RSMUSShipToPhoneNo;
                        end
                        else
                        begin
                            RSMUSShipToAddress[RSMUSCount]:=RSMUSShipToPhoneNo;
                        end;
                        break;
                    end;
                end;
                if RSMUSSalespersonPurchaser.Get(RSMUSSalesShipmentHeader."Salesperson Code")then RSMUSSalespersonName:=RSMUSSalespersonPurchaser.Name;
                if RSMUSPaymentTerms.Get(RSMUSSalesShipmentHeader."Payment Terms Code")then RSMUSPaymentTermsDescription:=RSMUSPaymentTerms.Description;
            end;
            // if RSMUSSalesLine.Get(RSMUSSalesLine."Document Type"::Order, "Sales Shipment Line"."Source No.", "Sales Shipment Line"."Source Line No.") then begin
            // end;
            // if ("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) AND (RSMUSItem.Get("Sales Shipment Line"."No.")) then begin
            //     if RSMUSItem."Gross Weight" <> 0 then begin
            //         RSMUSShippingWeight := RSMUSItem."Gross Weight" * "Sales Shipment Line"."Quantity (Base)";
            //         if RSMUSShippingWeight <> 0 then
            //             RSMUSShippingWeightTxt := Format(RSMUSShippingWeight) + '/LBS'
            //         else
            //             RSMUSShippingWeightTxt := '';
            //     end;
            // end;
            RSMUSShippingWeight:="Sales Shipment Line".RSMUSGrossWeight * "Sales Shipment Line"."Quantity (Base)";
            if RSMUSShippingWeight <> 0 then RSMUSShippingWeightTxt:=Format(RSMUSShippingWeight) + '/LBS'
            else
                RSMUSShippingWeightTxt:='';
            if RSMUSShippingAgent.Get("Sales Shipment Header"."Shipping Agent Code")then begin
                RSMUSShippingAgentDescription:=RSMUSShippingAgent.Name;
            end;
            if RSMUSShippingAgentServices.Get("Sales Shipment Header"."Shipping Agent Code", "Sales Shipment Header"."Shipping Agent Service Code")then begin
                RSMUSShippingAgentServiceDescription:=RSMUSShippingAgentServices.Description;
            end;
            if RSMUSShipmentMethod.Get("Sales Shipment Header"."Shipment Method Code")then begin
                RSMUSShipmentMethodDescription:=RSMUSShipmentMethod.Description;
            end;
            RSMUSQuantityBO:="Sales Shipment Line".RSMUSPackingSlipQuantity - "Sales Shipment Line".Quantity;
            if("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) AND (RSMUSItem.Get("Sales Shipment Line"."No.")) AND RSMUSSATHazardousMaterial.Get(RSMUSItem."SAT Hazardous Material")then RSMUSSATHazardousDescription:=RSMUSSATHazardousMaterial.Description;
        end;
        }
        addafter("Sales Shipment Line")
        {
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
        add("Sales Comment Line")
        {
            column(RSMUSLine_No_; "Line No.")
            {
            }
            column(RSMUSComment; Comment)
            {
            }
        }
        addlast("Sales Shipment Line")
        {
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Document No."=field("Document No."), "Document Line No."=field("Line No.");
                DataItemTableView = where("Lot No."=filter(<>''), "Entry Type"=const("Entry Type"::"Sale"));

                column(RSMUSLot_No_; "Lot No.")
                {
                }
                column(RSMUSLotQuantity;(Quantity * "Qty. per Unit of Measure" * -1))
                {
                }
                // column(RSMUSLotQtyTxt; Format(-Quantity) + "Sales Shipment Line"."Unit of Measure Code")
                // { }
                column(RSMUSBaseUOM; RSMUSLotItem."Base Unit of Measure")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Sales Shipment Line".Type = "Sales Shipment Line".Type::Item then if RSMUSLotItem.Get("Sales Shipment Line"."No.")then;
                end;
            }
        }
    }
    rendering
    {
        layout(PSGPurchCrMemo)
        {
            Caption = 'PSG Sales Shipment';
            Summary = 'PSG Sales Shipment';
            Type = RDLC;
            LayoutFile = './src/ReportExt/Layouts/Rep10077-Ext50105.RSMUSSalesShipmentNA.rdl';
        }
    }
    trigger OnPreReport()
    begin
        if RSMUSCompanyInformation.Get()then RSMUSCompanyInformation.CalcFields(Picture);
    end;
    var RSMUSCompanyInformation: Record "Company Information";
    RSMUSSalesShipmentHeader: Record "Sales Shipment Header";
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
    RSMUSPostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";
    RSMUSFormatAddress: Codeunit "Format Address";
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
    RSMUSCurrReportPageNoCaptionLbl: Label 'Page';
    RSMUSSATHazardousDescription: Text[250];
    procedure RSMUSSalesHeaderSellTo(var AddrArray: array[8]of Text[100]; var SalesHeader: Record "Sales Shipment Header")
    begin
        RSMUSFormatAddress.FormatAddr(AddrArray, SalesHeader."Sell-to Customer Name", SalesHeader."Sell-to Customer Name 2", '', SalesHeader."Sell-to Address", SalesHeader."Sell-to Address 2", SalesHeader."Sell-to City", SalesHeader."Sell-to Post Code", SalesHeader."Sell-to County", SalesHeader."Sell-to Country/Region Code");
    end;
    procedure RSMUSSalesHeaderShipTo(var AddrArray: array[8]of Text[100]; CustAddr: array[8]of Text[100]; var SalesHeader: Record "Sales Shipment Header")Result: Boolean var
        CountryRegion: Record "Country/Region";
        SellToCountry: Code[50];
        RSMUSi: Integer;
    begin
        RSMUSFormatAddress.FormatAddr(AddrArray, SalesHeader."Ship-to Name", SalesHeader."Ship-to Name 2", '', SalesHeader."Ship-to Address", SalesHeader."Ship-to Address 2", SalesHeader."Ship-to City", SalesHeader."Ship-to Post Code", SalesHeader."Ship-to County", SalesHeader."Ship-to Country/Region Code");
        if CountryRegion.Get(SalesHeader."Sell-to Country/Region Code")then SellToCountry:=CountryRegion.Name;
        if SalesHeader."Sell-to Customer No." <> SalesHeader."Bill-to Customer No." then exit(true);
        for RSMUSi:=1 to ArrayLen(AddrArray)do if(AddrArray[RSMUSi] <> CustAddr[RSMUSi]) and (AddrArray[RSMUSi] <> '') and (AddrArray[RSMUSi] <> SellToCountry)then exit(true);
        exit(false);
    end;
}

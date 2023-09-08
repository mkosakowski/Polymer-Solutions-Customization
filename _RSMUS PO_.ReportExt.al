reportextension 50101 "RSMUS PO" extends "Purchase Order" //10122
{
    //RSM10332 MGZ 10/20/2022 BRD-0009: Geneis: Custom PO report off of report ID 10122
    //RSM14788 JRO 2023-08-10 BRD-0011: Purchase Order report modifications
    dataset
    {
        add("Purchase Header")
        {
            column(RSMUSCompanyPic; gCompany.Picture)
            {
            }
            column(RSMUSShippingAgentHdr; RSMUSShippingAgentName)
            {
            }
            column(RSMUS_Ship_Agent_Account_No_; "RSMUS Ship Agent Account No.")
            {
            }
            column(RSMUSCOAFalse; gCOAFalse)
            {
            }
            column(RSMUSCOATrue; gCOATrue)
            {
            }
            column(RSMUSCOAEmail; COAEmail)
            {
            }
            column(RSMUSReceivingCOAEmail; RSMUSReceivingCOAEmail)
            {
            }
            column(RSMUSPrintShippingName; RSMUSPrintShippingName)
            {
            }
            column(RSMUSCompanyAddress1; RSMUSCompanyAddress[1])
            {
            }
            column(RSMUSCompanyAddress2; RSMUSCompanyAddress[2])
            {
            }
            column(RSMUSCompanyAddress3; RSMUSCompanyAddress[3])
            {
            }
            column(RSMUSCompanyAddress4; RSMUSCompanyAddress[4])
            {
            }
            column(RSMUSCompanyAddress5; RSMUSCompanyAddress[5])
            {
            }
            column(RSMUSCompanyAddress6; RSMUSCompanyAddress[6])
            {
            }
            column(RSMUSBuyFromAddress1; RSMUSBuyFromAddress[1])
            {
            }
            column(RSMUSBuyFromAddress2; RSMUSBuyFromAddress[2])
            {
            }
            column(RSMUSBuyFromAddress3; RSMUSBuyFromAddress[3])
            {
            }
            column(RSMUSBuyFromAddress4; RSMUSBuyFromAddress[4])
            {
            }
            column(RSMUSBuyFromAddress5; RSMUSBuyFromAddress[5])
            {
            }
            column(RSMUSBuyFromAddress6; RSMUSBuyFromAddress[6])
            {
            }
            column(RSMUSBuyFromAddress7; RSMUSBuyFromAddress[7])
            {
            }
            column(RSMUSLocationReceivingHours; RSMUSLocation.RSMUSReceivingHours)
            {
            }
        }
        add(PageLoop)
        {
            column(RSMUSRequested_Receipt_Date; "Purchase Header"."Requested Receipt Date")
            {
            }
            column(RSMUSShippingAgent; RSMUSShippingAgentName)
            {
            }
            column(RSMUSPickupNo; "Purchase Header"."RSMUS Pickup No.")
            {
            }
            column(RSMUSBuyFromPhone; PhoneNo)
            {
            }
            column(RSMUSBuyFromEmail; Email)
            {
            }
            column(RSMUSPrintCOABool; RSMUSPrintCOABool)
            {
            }
            column(RSMUSTotalCaption; GetTotalCaption("Purchase Header"."Currency Code"))
            {
            //RSM14788
            }
            column(RSMUSShipToAddrArr1; ShipToAddrArr[1])
            {
            //RSM14788
            }
            column(RSMUSShipToAddrArr2; ShipToAddrArr[2])
            {
            //RSM14788
            }
            column(RSMUSShipToAddrArr3; ShipToAddrArr[3])
            {
            //RSM14788
            }
            column(RSMUSShipToAddrArr4; ShipToAddrArr[4])
            {
            //RSM14788
            }
            column(RSMUSShipToAddrArr5; ShipToAddrArr[5])
            {
            //RSM14788
            }
            column(RSMUSShipToAddrArr6; ShipToAddrArr[6])
            {
            //RSM14788
            }
            column(RSMUSShipToAddrArr7; ShipToAddrArr[7])
            {
            //RSM14788
            }
            column(RSMUSYourRef_PurchHeader; "Purchase Header"."Your Reference")
            {
            //RSM14788
            }
            column(RSMUSReceiveLbl; _ReceiveLbl)
            {
            //RSM14788 
            }
            column(RSMUSReceiveInfo; _ReceiveInfo)
            {
            //RSM14788 
            }
        }
        add("Purchase Line")
        {
            column(RSMUSLine_No_; "Line No.")
            {
            }
            column(RSMUSItem_Reference_No_; "Item Reference No.")
            {
            }
            column(RSMUSRequested_Receipt_DateLine; "Requested Receipt Date")
            {
            }
            column(RSMUSLine_Amount; "Line Amount")
            {
            }
            column(RSMUSNo; "No.")
            {
            }
            column(RSMUSUOMCode_PurchaseLine; "Unit of Measure Code")
            {
            //RSM14788
            }
        }
        addlast("Purchase Header")
        {
            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLink = "No."=FIELD("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.")WHERE("Document Type"=CONST(Order), "RSMUS Print Comment"=const(true));

                column(RSMUSComment; Comment)
                {
                }
            }
        }
        modify("Purchase Header")
        {
        trigger OnBeforePreDataItem()
        begin
            "Purchase Header".SetAutoCalcFields(RSMUSHasDropShipLine); //RSM14788
        end;
        trigger OnAfterAfterGetRecord()
        var
            lPurchPayables: Record "Purchases & Payables Setup";
            RSMUSShippingAgent: Record "Shipping Agent";
            DropShipReceivRefTxt: Label 'Receiver''s Reference:';
            ReceivRefTxt: Label 'Receiving Hours:';
        begin
            if RSMUSShippingAgent.Get("Purchase Header"."RSMUS Shipping Agent Code")then RSMUSShippingAgentName:=RSMUSShippingAgent.Name;
            Clear(COAEmail);
            If lPurchPayables.Get()then COAEmail:=lPurchPayables."RSMUS Purchasing Email";
            If gCompany.Get()then begin
                gCompany.Calcfields(Picture);
                if gCompany.Name = "Ship-to Name" then RSMUSPrintShippingName:=true;
                FormatAddressCU.Company(RSMUSCompanyAddress, gCompany);
            end;
            "Purchase Header".CalcFields("RSMUS Ship Agent Account No.");
            Clear(gCOAFalse);
            Clear(gCOATrue);
            If "RSMUS COA Required" then begin
                gCOATrue:='X';
                gCOAFalse:=' ';
            end
            else
            begin
                gCOAFalse:='X';
                gCOATrue:=' ';
            end;
            if "RSMUS COA Required" then RSMUSPrintCOABool:=true;
            FormatAddressCU.FormatAddr(RSMUSBuyFromAddress, "Buy-from Vendor Name", '', '', "Buy-from Address", "Buy-from Address 2", "Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code");
            if RSMUSLocation.Get("Purchase Header"."Location Code")then;
            //RSM14788 >>
            FormatAddressCU.FormatAddr(ShipToAddrArr, "Ship-to Name", '', '', "Ship-to Address", "Ship-to Address 2", "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code");
            if "Purchase Header".RSMUSHasDropShipLine then begin
                _ReceiveLbl:=DropShipReceivRefTxt;
                _ReceiveInfo:="Purchase Header"."Your Reference";
            end
            else
            begin
                _ReceiveLbl:=ReceivRefTxt;
                _ReceiveInfo:=RSMUSLocation.RSMUSReceivingHours;
            end;
        //RSM14788 <<
        end;
        }
        modify(PageLoop)
        {
        trigger OnAfterAfterGetRecord()
        var
            lVendor: Record Vendor;
            RSMUSShippingAgent: Record "Shipping Agent";
        begin
            if RSMUSShippingAgent.Get("Purchase Header"."RSMUS Shipping Agent Code")then RSMUSShippingAgentName:=RSMUSShippingAgent.Name;
            Clear(PhoneNo);
            Clear(Email);
            If lVendor.get("Purchase Header"."Buy-from Vendor No.")then begin
                PhoneNo:=lVendor."Phone No.";
                Email:=lVendor."E-Mail";
            end end;
        }
    }
    rendering
    {
        layout(PSGPurchOrder)
        {
            Caption = 'PSG Purchase Order';
            Summary = 'PSG Purchase Order';
            Type = RDLC;
            LayoutFile = './src/ReportExt/Layouts/Rep10122-Ext50101.RSMUSPO.rdl';
        }
    }
    trigger OnPreReport()
    var
        QMQualityMgmtSetup: Record "RSMUS QM Quality Mgmt Setup";
    begin
        RSMUSPrintCOABool:=false;
        RSMUSPrintShippingName:=false;
        if QMQualityMgmtSetup.Get()then begin
            RSMUSReceivingCOAEmail:=QMQualityMgmtSetup.RSMUSReceivingCOAEmail;
        end;
    end;
    var gCompany: Record "Company Information";
    RSMUSLocation: Record Location;
    FormatAddressCU: Codeunit "Format Address";
    gCOATrue: Text[1];
    gCOAFalse: Text[1];
    PhoneNo: Text[30];
    Email: Text[80];
    COAEmail: Text[80];
    RSMUSReceivingCOAEmail: Text[50];
    RSMUSPrintCOABool: Boolean;
    RSMUSPrintShippingName: Boolean;
    RSMUSCompanyAddress: array[8]of Text[100];
    RSMUSBuyFromAddress: array[8]of Text[100];
    ShipToAddrArr: array[8]of Text[100];
    RSMUSShippingAgentName: Text[50];
    _ReceiveInfo: text;
    _ReceiveLbl: text;
    local procedure GetTotalCaption(Curr: code[10]): text var
        TotalLbl: Label 'Total %1:', Comment = '%1 currency';
    begin
        //RSM14788 >>
        if Curr = '' then Curr:='USD';
        exit(StrSubstNo(TotalLbl, Curr));
    //RSM14788 <<
    end;
}

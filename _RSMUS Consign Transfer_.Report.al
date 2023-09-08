report 50101 "RSMUS Consign Transfer"
{
    //#9932 RDLC layout and company pic added
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layouts/Rep50101.RSMUSConsignTransfer.rdl';
    Caption = 'Consign Transfer Order';

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Transfer Order';

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
            column(No_TransferHdr; "No.")
            {
            }
            column(TransferOrderNoCaption; TransferOrderNoCaptionLbl)
            {
            }
            column(RSMUS_Customer_No_; "RSMUS Customer No.")
            {
            }
            column(CustomerAddress; CustomerAddress)
            {
            }
            column(RSMUSPicture; gCompany.Picture)
            {
            }
            column(ShipmentMethod; "Shipment Method Code")
            {
            }
            column(ShipmentDate; Format("Shipment Date", 0, '<Month,2>/<Day,2>/<Year4>'))
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
            column(RSMUSExternalDocNo; "Transfer Header"."External Document No.")
            {
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
                    column(CopyCaption; StrSubstNo(Text001, CopyText))
                    {
                    }
                    column(TransferToAddr1; TransferToAddr[1])
                    {
                    }
                    column(TransferFromAddr1; TransferFromAddr[1])
                    {
                    }
                    column(TransferToAddr2; TransferToAddr[2])
                    {
                    }
                    column(TransferFromAddr2; TransferFromAddr[2])
                    {
                    }
                    column(TransferToAddr3; TransferToAddr[3])
                    {
                    }
                    column(TransferFromAddr3; TransferFromAddr[3])
                    {
                    }
                    column(TransferToAddr4; TransferToAddr[4])
                    {
                    }
                    column(TransferFromAddr4; TransferFromAddr[4])
                    {
                    }
                    column(TransferToAddr5; TransferToAddr[5])
                    {
                    }
                    column(TransferToAddr6; TransferToAddr[6])
                    {
                    }
                    column(InTransitCode_TransHdr; "Transfer Header"."In-Transit Code")
                    {
                    IncludeCaption = true;
                    }
                    column(PostingDate_TransHdr; Format("Transfer Header"."Posting Date", 0, '<Month,2>/<Day,2>/<Year4>'))
                    {
                    }
                    column(TransferToAddr7; TransferToAddr[7])
                    {
                    }
                    column(TransferToAddr8; TransferToAddr[8])
                    {
                    }
                    column(TransferFromAddr5; TransferFromAddr[5])
                    {
                    }
                    column(TransferFromAddr6; TransferFromAddr[6])
                    {
                    }
                    column(PageCaption; StrSubstNo(Text002, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ShptMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Transfer Header";
                        DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                        column(DimText; DimText)
                        {
                        }
                        column(Number_DimensionLoop1; Number)
                        {
                        }
                        column(HdrDimensionsCaption; HdrDimensionsCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet()then CurrReport.Break();
                            end
                            else if not Continue then CurrReport.Break();
                            Clear(DimText);
                            Continue:=false;
                            repeat OldDimText:=DimText;
                                if DimText = '' then DimText:=StrSubstNo('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText:=StrSubstNo('%1; %2 - %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                    DimText:=OldDimText;
                                    Continue:=true;
                                    exit;
                                end;
                            until DimSetEntry1.Next() = 0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then CurrReport.Break();
                        end;
                    }
                    dataitem("Transfer Line"; "Transfer Line")
                    {
                        DataItemLink = "Document No."=FIELD("No.");
                        DataItemLinkReference = "Transfer Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")WHERE("Derived From Line No."=CONST(0));

                        column(ItemNo_TransLine; "Item No.")
                        {
                        IncludeCaption = true;
                        }
                        column(Desc_TransLine; Description)
                        {
                        IncludeCaption = true;
                        }
                        column(Qty_TransLine; Quantity)
                        {
                        IncludeCaption = true;
                        }
                        column(UOM_TransLine; "Unit of Measure Code")
                        {
                        IncludeCaption = true;
                        }
                        column(Qty_TransLineShipped; "Quantity Shipped")
                        {
                        IncludeCaption = true;
                        }
                        column(QtyReceived_TransLine; "Quantity Received")
                        {
                        IncludeCaption = true;
                        }
                        column(TransFromBinCode_TransLine; "Transfer-from Bin Code")
                        {
                        IncludeCaption = true;
                        }
                        column(TransToBinCode_TransLine; "Transfer-To Bin Code")
                        {
                        IncludeCaption = true;
                        }
                        column(LineNo_TransLine; "Line No.")
                        {
                        }
                        column(RSMUS_Item_Reference_No_; "RSMUS Item Reference No.")
                        {
                        }
                        column(RSMUS_Packaging; "RSMUS Packaging")
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                            column(DimText2; DimText)
                            {
                            }
                            column(Number_DimensionLoop2; Number)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet()then CurrReport.Break();
                                end
                                else if not Continue then CurrReport.Break();
                                Clear(DimText);
                                Continue:=false;
                                repeat OldDimText:=DimText;
                                    if DimText = '' then DimText:=StrSubstNo('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText:=StrSubstNo('%1; %2 - %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                        DimText:=OldDimText;
                                        Continue:=true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next() = 0;
                            end;
                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then CurrReport.Break();
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            DimSetEntry2.SetRange("Dimension Set ID", "Dimension Set ID");
                        end;
                    }
                    trigger OnAfterGetRecord()
                    var
                        Location: Record Location;
                    begin
                        if Location.Get("Transfer Header"."Transfer-from Code")then begin
                            FormatAddress.FormatAddr(LocationAddress, Location.Name, Location."Name 2", '', Location.Address, Location."Address 2", Location.City, Location."Post Code", Location.County, Location."Country/Region Code");
                        end;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText:=Text000;
                        OutputNo+=1;
                    end;
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=Abs(NoOfCopies) + 1;
                    CopyText:='';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo:=1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                lCustomer: Record Customer;
                ShipmentMethod: Record "Shipment Method";
                ShippingAgent: Record "Shipping Agent";
                ShippingAgentServices: Record "Shipping Agent Services";
            begin
                Clear(CustomerAddress);
                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
                FormatAddr.TransferHeaderTransferFrom(TransferFromAddr, "Transfer Header");
                FormatAddr.TransferHeaderTransferTo(TransferToAddr, "Transfer Header");
                if not ShipmentMethod.Get("Shipment Method Code")then ShipmentMethod.Init();
                If lCustomer.Get("Transfer Header"."RSMUS Customer No.")then CustomerAddress:=GetCustomCustomerAddress(lCustomer);
                if gCompany.Get()then gCompany.CalcFields(Picture);
                if ShipmentMethod.Get("Transfer Header"."Shipment Method Code")then RSMUSShipmentMethodDescription:=ShipmentMethod.Description;
                if ShippingAgent.Get("Transfer Header"."Shipping Agent Code")then RSMUSShippingAgentName:=ShippingAgent.Name;
                if ShippingAgentServices.Get("Transfer Header"."Shipping Agent Code", "Transfer Header"."Shipping Agent Service Code")then RSMUSShippingAgentServiceDescription:=ShippingAgentServices.Description;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Location;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Location;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    PostingDateCaption='Posting Date';
    ShptMethodDescCaption='Shipment Method';
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        FormatAddress.Company(CompanyAddress, CompanyInformation)end;
    var CompanyInformation: Record "Company Information";
    ShipmentMethod: Record "Shipment Method";
    DimSetEntry1: Record "Dimension Set Entry";
    DimSetEntry2: Record "Dimension Set Entry";
    gCompany: Record "Company Information";
    FormatAddress: Codeunit "Format Address";
    FormatAddr: Codeunit "Format Address";
    Text000: Label 'COPY';
    Text001: Label 'Transfer Order %1';
    Text002: Label 'Page %1';
    TransferFromAddr: array[8]of Text[100];
    TransferToAddr: array[8]of Text[100];
    NoOfCopies: Integer;
    NoOfLoops: Integer;
    CopyText: Text[30];
    DimText: Text[120];
    OldDimText: Text[75];
    ShowInternalInfo: Boolean;
    Continue: Boolean;
    OutputNo: Integer;
    HdrDimensionsCaptionLbl: Label 'Header Dimensions';
    LineDimensionsCaptionLbl: Label 'Line Dimensions';
    TransferOrderNoCaptionLbl: Label 'Transfer Order No.';
    CustomerAddress: Text;
    CompanyAddress: array[8]of Text[100];
    LocationAddress: array[8]of Text[100];
    RSMUSShipmentMethodDescription: Text[100];
    RSMUSShippingAgentName: Text[50];
    RSMUSShippingAgentServiceDescription: Text[100];
    procedure GetCustomCustomerAddress(var Customer: Record "Customer"): Text var
        lCountry: Record "Country/Region";
        CRLF: Text;
        lCustomerAddress: Text;
    begin
        Clear(lCustomerAddress);
        CRLF:=' ';
        CRLF[1]:=13;
        CRLF[2]:=10;
        If Customer."Address 2" <> '' then lCustomerAddress+=Customer.Name + CRLF + Customer."Address" + CRLF + Customer."Address 2" + CRLF + Customer."City" + ', ' + Customer."County" + ' ' + Customer."Post Code"
        else
            lCustomerAddress+=Customer.Name + CRLF + Customer."Address" + CRLF + Customer."City" + ', ' + Customer."County" + ' ' + Customer."Post Code";
        If lCountry.get(Customer."Country/Region Code")then lCustomerAddress+=CRLF + lCountry.Name;
        exit(lCustomerAddress);
    end;
}

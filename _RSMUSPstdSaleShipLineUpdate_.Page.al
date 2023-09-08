page 50109 "RSMUSPstdSaleShipLineUpdate"
{
    //RSM11506 BJK 2023-02-23 BRD-0024: Posted Sales Shipment Packing Slip
    Caption = 'Posted Sales Shipment Line - Update';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Sales Shipment Line";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("DocumentNo."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Document No.';
                }
                field(LineNo; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                    Editable = false;
                }
                field(RSMUSNetWeight; Rec.RSMUSNetWeight)
                {
                    ApplicationArea = All;
                    Caption = 'Net Weight';
                }
                field(RSMUSGrossWeight; Rec.RSMUSGrossWeight)
                {
                    ApplicationArea = All;
                    Caption = 'Gross Weight';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        xSalesShipmentLine:=Rec;
    end;
    trigger OnQueryClosePage(CloseAction: Action): Boolean var
    begin
        if CloseAction = ACTION::LookupOK then if RecordChanged()then CODEUNIT.Run(CODEUNIT::RSMUSShipmentLineEdit, Rec);
    end;
    var xSalesShipmentLine: Record "Sales Shipment Line";
    local procedure RecordChanged()IsChanged: Boolean begin
        IsChanged:=(Rec.RSMUSNetWeight <> xSalesShipmentLine.RSMUSNetWeight) or (Rec.RSMUSGrossWeight <> xSalesShipmentLine.RSMUSGrossWeight);
    end;
    procedure SetRec(SalesShipmentLine: Record "Sales Shipment Line")
    begin
        Rec:=SalesShipmentLine;
        Rec.Insert();
    end;
}

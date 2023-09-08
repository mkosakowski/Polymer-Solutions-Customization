codeunit 50109 "RSMUSShipmentLineEdit"
{
    //RSM11506 BJK 2023-02-23 BRD-0024: Posted Sales Shipment Packing Slip
    Permissions = TableData "Sales Shipment Line"=imd;
    TableNo = "Sales Shipment Line";

    trigger OnRun()
    begin
        SalesShipmentLine:=Rec;
        SalesShipmentLine.LockTable();
        SalesShipmentLine.Find();
        SalesShipmentLine."Package Tracking No.":=Rec."Package Tracking No.";
        SalesShipmentLine.RSMUSNetWeight:=Rec.RSMUSNetWeight;
        SalesShipmentLine.RSMUSGrossWeight:=Rec.RSMUSGrossWeight;
        SalesShipmentLine.Modify();
        Rec:=SalesShipmentLine;
    end;
    var SalesShipmentLine: Record "Sales Shipment Line";
}

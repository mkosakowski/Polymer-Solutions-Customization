pageextension 50101 "RSMUS Posted Sales Shmpnt SF" extends "Posted Sales Shpt. Subform" //131
{
    layout
    {
        addlast(Control1)
        {
            field(RSMUSNetWeight; Rec.RSMUSNetWeight)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RSMUSGrossWeight; Rec.RSMUSGrossWeight)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(content)
        {
            field(RSMUSPackaging; Rec."RSMUS Packaging")
            {
                Caption = 'Packaging';
                ApplicationArea = All;
            }
            group(RSMUSTotals)
            {
                ShowCaption = false;

                field(RSMUSNetWeightTotal; RSMUSSalesShipmentHeader.RSMUSNetWeightTotal)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Net Weight Total';
                }
                field(RSMUSGrossWeightTotal; RSMUSSalesShipmentHeader.RSMUSGrossWeightTotal)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Gross Weight Total';
                }
            }
        }
    }
    actions
    {
        addlast("&Line")
        {
            action(RSMUSUpdateLine)
            {
                ApplicationArea = Suite;
                Caption = 'Update Line';
                Image = Edit;

                trigger OnAction()
                var
                    PostedSalesShipmentLineUpdate: Page RSMUSPstdSaleShipLineUpdate;
                begin
                    PostedSalesShipmentLineUpdate.LookupMode:=true;
                    PostedSalesShipmentLineUpdate.SetRec(Rec);
                    PostedSalesShipmentLineUpdate.RunModal();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if RSMUSSalesShipmentHeader.Get(Rec."Document No.")then begin
            RSMUSSalesShipmentHeader.CalcFields(RSMUSGrossWeightTotal);
            RSMUSSalesShipmentHeader.CalcFields(RSMUSNetWeightTotal);
        end;
    end;
    var RSMUSSalesShipmentHeader: Record "Sales Shipment Header";
}

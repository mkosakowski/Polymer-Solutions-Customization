pageextension 50125 "RSMUS Whse. Shpmnt SF" extends "Whse. Shipment Subform" //7336
{
    layout
    {
        //RSM11194 >>
        modify("Qty. to Ship (Base)")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                if Item.Get(Rec."Item No.")then begin
                    Rec.Validate(RSMUSNetWeight, Item."Net Weight" * Rec."Qty. to Ship (Base)");
                    Rec.Validate(RSMUSGrossWeight, Item."Gross Weight" * Rec."Qty. to Ship (Base)");
                end;
                CurrPage.Update();
            end;
        }
        addlast(Control1)
        {
            field(RSMUSNetWeight; Rec.RSMUSNetWeight)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
            field(RSMUSGrossWeight; Rec.RSMUSGrossWeight)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
        }
        addlast(content)
        {
            group(RSMUSTotals)
            {
                ShowCaption = false;

                field(RSMUSNetWeightTotal; RSMUSWarehouseShipmentHeader.RSMUSNetWeightTotal)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Net Weight Total';

                    trigger OnValidate()
                    begin
                        RSMUSWarehouseShipmentHeader.CalcFields(RSMUSNetWeightTotal);
                    end;
                }
                field(RSMUSGrossWeightTotal; RSMUSWarehouseShipmentHeader.RSMUSGrossWeightTotal)
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
            action(RSMUSDDMS)
            {
                Image = OpenWorksheet;
                Caption = 'Invoice Routing';
                ToolTip = 'Lookup to the Invoice Routing Master Record for the Customer associated with this Sales Order';
                ApplicationArea = All;

                trigger OnAction()
                var
                    lDDMSMaster: Record "RSMUS DDMS Master";
                    lSO: Record "Sales Header";
                    RSMUSDDMSMaster: Page "RSMUS DDMS Master";
                begin
                    if lSO.Get(lSO."Document Type"::Order, rec."Source No.")then begin
                        if lDDMSMaster.Get(lSO."Sell-to Customer No.")then begin
                            RSMUSDDMSMaster.Editable(false);
                            RSMUSDDMSMaster.SetRecord(lDDMSMaster);
                            RSMUSDDMSMaster.Run();
                        end
                        else
                            Error('No Invoice Routing record exists for Customer %1 from Sales Order %2.', lSO."Sell-to Customer No.", Rec."Source No.");
                    end
                    else
                        Error('Source No. %1 is not a valid Sales Order.', Rec."Source No.");
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if RSMUSWarehouseShipmentHeader.Get(Rec."No.")then begin
            RSMUSWarehouseShipmentHeader.CalcFields(RSMUSGrossWeightTotal);
            RSMUSWarehouseShipmentHeader.CalcFields(RSMUSNetWeightTotal);
        end;
    end;
    var RSMUSWarehouseShipmentHeader: Record "Warehouse Shipment Header";
}

page 50106 "RSMUSStackingWorksheet"
{
    //RSM10564 BJK 11/13/2022 BRD-0042: 7th Ave Transfer Process
    Caption = 'Stacking Worksheet';
    PageType = Worksheet;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = RSMUSTempProdOrderComponent;
    SourceTableTemporary = true;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RSMUSSourceType; Rec.RSMUSSourceType)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RSMUSSourceNo; Rec.RSMUSSourceNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Quantity"; Rec."Expected Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RSMUSBagSize; Rec.RSMUSBagSize)
                {
                    ApplicationArea = All;
                }
                field(RSMUSBags; Rec.RSMUSBags)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RSMUSTransferValue; Rec.RSMUSTransferValue)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RSMUSReplenishmentSystem; Rec.RSMUSReplenishmentSystem)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RSMUSTransferFromCode; Rec.RSMUSTransferFromCode)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateTransferOrders)
            {
                ApplicationArea = All;
                Caption = 'Create Transfer Orders';

                trigger OnAction()
                var
                    ManufacturingSetup: Record "Manufacturing Setup";
                    CreateTransferOrdersCU: Codeunit RSMUSCreateTransferOrders;
                begin
                    if ManufacturingSetup.Get()then begin
                        if Dialog.Confirm(ManufacturingSetup.RSMUSStackingReminder)then begin
                            Clear(Rec);
                            CreateTransferOrdersCU.BeginCreateTransferOrders(Rec);
                        end;
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(RSMUSSourceType);
        Rec.CalcFields(RSMUSSourceNo);
        Rec.CalcFields(RSMUSReplenishmentSystem);
        Rec.CalcFields(RSMUSTransferFromCode);
    end;
    trigger OnOpenPage()
    var
        ProdOrderComponent: Record "Prod. Order Component";
    begin
        ProdOrderComponent.SetRange(Status, ProdOrderComponent.Status::Released);
        ProdOrderComponent.SetRange(RSMUSTransferOrderNo, '');
        if ProdOrderComponent.FindSet()then repeat ProdOrderComponent.CalcFields(RSMUSReplenishmentSystem);
                if(ProdOrderComponent.RSMUSReplenishmentSystem = ProdOrderComponent.RSMUSReplenishmentSystem::Transfer) AND (ProdOrderComponent."Qty. Picked" < ProdOrderComponent."Expected Quantity")then begin
                    CreateTempComponent(ProdOrderComponent);
                end;
            until ProdOrderComponent.Next() = 0;
    end;
    procedure CreateTempComponent(ProdOrderComponent: Record "Prod. Order Component")
    begin
        Clear(Rec);
        Rec.Init();
        Rec.Validate(Status, ProdOrderComponent.Status);
        Rec.Validate("Prod. Order No.", ProdOrderComponent."Prod. Order No.");
        Rec.Validate("Prod. Order Line No.", ProdOrderComponent."Prod. Order Line No.");
        Rec.Validate("Line No.", ProdOrderComponent."Line No.");
        //Rec.Validate(RSMUSSourceType, ProdOrderComponent.RSMUSSourceType);
        //Rec.Validate(RSMUSSourceNo, ProdOrderComponent.RSMUSSourceNo);
        Rec.Validate("Item No.", ProdOrderComponent."Item No.");
        Rec.Validate("Item No.", ProdOrderComponent."Item No.");
        Rec.Validate(Description, ProdOrderComponent.Description);
        Rec.Validate("Quantity per", ProdOrderComponent."Quantity per");
        Rec.Validate("Unit of Measure Code", ProdOrderComponent."Unit of Measure Code");
        Rec.Validate("Expected Quantity", ProdOrderComponent."Expected Quantity");
        Rec.Validate(RSMUSBagSize, ProdOrderComponent.RSMUSBagSize);
        Rec.Validate(RSMUSBags, ProdOrderComponent.RSMUSBags);
        Rec.Validate(RSMUSTransferValue, ProdOrderComponent.RSMUSTransferValue);
        Rec.Validate("Location Code", ProdOrderComponent."Location Code");
        Rec.Validate("Location Code", ProdOrderComponent."Location Code");
        //Rec.Validate(RSMUSReplenishmentSystem, ProdOrderComponent.RSMUSReplenishmentSystem);
        //Rec.Validate(RSMUSTransferFromCode, ProdOrderComponent.RSMUSTransferFromCode);
        Rec.Validate("Variant Code", ProdOrderComponent."Variant Code");
        Rec.Validate("Due Date", ProdOrderComponent."Due Date");
        Rec.Validate("Bin Code", ProdOrderComponent."Bin Code");
        Rec.Insert();
    end;
}

tableextension 50131 "RSMUSProdOrderComponent" extends "Prod. Order Component" //5407
{
    fields
    {
        field(50100; RSMUSSourceType;Enum "Prod. Order Source Type")
        {
            Caption = 'Source Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."Source Type" where(Status=field(Status), "No."=field("Prod. Order No.")));
        }
        field(50101; RSMUSSourceNo; Code[20])
        {
            Caption = 'Source No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."Source No." where(Status=field(Status), "No."=field("Prod. Order No.")));
        }
        field(50102; RSMUSReplenishmentSystem;Enum "Replenishment System")
        {
            Caption = 'Replenishment System';
            FieldClass = FlowField;
            CalcFormula = lookup("Stockkeeping Unit"."Replenishment System" where("Location Code"=field("Location Code"), "Item No."=field("Item No."), "Variant Code"=field("Variant Code")));
        }
        field(50103; RSMUSTransferFromCode; Code[10])
        {
            Caption = 'Transfer From';
            FieldClass = FlowField;
            CalcFormula = lookup("Stockkeeping Unit"."Transfer-from Code" where("Location Code"=field("Location Code"), "Item No."=field("Item No."), "Variant Code"=field("Variant Code")));
        }
        field(50104; RSMUSBagSize; Decimal)
        {
            Caption = 'Bag Size';

            trigger OnValidate()
            begin
                if RSMUSBagSize <> 0 then begin
                    Validate(RSMUSBags, System.Round("Expected Quantity" / RSMUSBagSize, 1, '<'));
                    Validate(RSMUSTransferValue, RSMUSBags * RSMUSBagSize);
                end;
            end;
        }
        field(50105; RSMUSBags; Integer)
        {
            Caption = 'Bags';
        }
        field(50106; RSMUSTransferValue; Decimal)
        {
            Caption = 'Transfer Value';
        }
        field(50107; RSMUSTransferOrderNo; Code[20])
        {
        }
        modify("Expected Quantity")
        {
        trigger OnAfterValidate()
        begin
            if RSMUSBagSize <> 0 then begin
                Validate(RSMUSBags, System.Round("Expected Quantity" / RSMUSBagSize, 1, '<'));
                Validate(RSMUSTransferValue, RSMUSBags * RSMUSBagSize);
            end;
        end;
        }
    }
}

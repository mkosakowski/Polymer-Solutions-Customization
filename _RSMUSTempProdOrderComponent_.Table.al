table 50106 "RSMUSTempProdOrderComponent"
{
    //RSM10564 BJK 11/13/2022 BRD-0042: 7th Ave Transfer Process
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; Status;Enum "Production Order Status")
        {
            Caption = 'Status';
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." WHERE(Status=FIELD(Status));
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status=FIELD(Status), "Prod. Order No."=FIELD("Prod. Order No."));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; RSMUSSourceType;Enum "Prod. Order Source Type")
        {
            Caption = 'Source Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."Source Type" where(Status=field(Status), "No."=field("Prod. Order No.")));
        }
        field(11; RSMUSSourceNo; Code[20])
        {
            Caption = 'Source No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."Source No." where(Status=field(Status), "No."=field("Prod. Order No.")));
        }
        field(20; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item WHERE(Type=FILTER(Inventory|"Non-Inventory"));
        }
        field(30; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(40; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            DecimalPlaces = 0: 5;
        }
        field(60; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No."=FIELD("Item No."));
        }
        field(70; "Expected Quantity"; Decimal)
        {
            Caption = 'Expected Quantity';
            DecimalPlaces = 0: 5;

            trigger OnValidate()
            begin
                if RSMUSBagSize <> 0 then begin
                    Validate(RSMUSBags, System.Round("Expected Quantity" / RSMUSBagSize, 1, '<'));
                    Validate(RSMUSTransferValue, RSMUSBags * RSMUSBagSize);
                end;
            end;
        }
        field(80; RSMUSBagSize; Decimal)
        {
            Caption = 'Bag Size';

            trigger OnValidate()
            begin
                if RSMUSBagSize <> 0 then begin
                    Validate(RSMUSBags, System.Round("Expected Quantity" / RSMUSBagSize, 1, '<'));
                    Validate(RSMUSTransferValue, RSMUSBags * RSMUSBagSize);
                end
                else
                begin
                    Validate(RSMUSBags, 0);
                    Validate(RSMUSTransferValue, 0);
                end;
            end;
        }
        field(81; RSMUSBags; Integer)
        {
            Caption = 'Bags';
        }
        field(90; RSMUSTransferValue; Decimal)
        {
            Caption = 'Transfer Value';
        }
        field(100; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit"=CONST(false));
        }
        field(110; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code"=FIELD("Location Code"));
        }
        field(120; RSMUSReplenishmentSystem;Enum "Replenishment System")
        {
            Caption = 'Replenishment System';
            FieldClass = FlowField;
            CalcFormula = lookup("Stockkeeping Unit"."Replenishment System" where("Location Code"=field("Location Code"), "Item No."=field("Item No."), "Variant Code"=field("Variant Code")));
        }
        field(130; RSMUSTransferFromCode; Code[10])
        {
            Caption = 'Transfer From';
            FieldClass = FlowField;
            CalcFormula = lookup("Stockkeeping Unit"."Transfer-from Code" where("Location Code"=field("Location Code"), "Item No."=field("Item No."), "Variant Code"=field("Variant Code")));
        }
        field(140; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No."=FIELD("Item No."));
        }
    }
    keys
    {
        key(PK; Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.")
        {
            Clustered = true;
        }
    }
}

tableextension 50132 "RSMUSIWXLPHeader" extends "IWX LP Header" //23044330
{
    fields
    {
        field(50100; RSMUSProdOrderNo; Code[20])
        {
            Caption = 'Production No.';
            TableRelation = "Production Order"."No." where(Status=const(Released));

            trigger OnValidate()
            var
                ProductionOrder: Record "Production Order";
            begin
                if ProductionOrder.Get(ProductionOrder.Status::Released, RSMUSProdOrderNo)then begin
                    Validate(RSMUSSourceType, ProductionOrder."Source Type");
                    Validate(RSMUSSourceNo, ProductionOrder."Source No.");
                    Validate(RSMUSDescription, ProductionOrder.Description);
                end;
            end;
        }
        field(50101; RSMUSSourceType;Enum "Prod. Order Source Type")
        {
            Caption = 'Source Type';
        }
        field(50102; RSMUSSourceNo; Code[20])
        {
            Caption = 'Source Number';
        }
        field(50103; RSMUSDescription; Text[100])
        {
            Caption = 'Description';
        }
    }
}

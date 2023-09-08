tableextension 50101 "RSMUSTransferLine" extends "Transfer Line" //5741
{
    fields
    {
        field(50100; "RSMUS Packaging"; Text[10])
        {
            Caption = 'Packaging';
        }
        field(50101; "RSMUS Item Reference No."; Code[50])
        {
            AccessByPermission = TableData "Item Reference"=R;
            Caption = 'Item Reference No.';

            trigger OnLookup()
            begin
                TransferReferenceNoLookup(Rec);
            end;
            trigger OnValidate()
            var
                ItemReference2: Record "Item Reference";
                TransferHeader: record "Transfer Header";
            begin
                If TransferHeader.Get(rec."Document No.")then begin
                    ItemReference2.SetFilter("Reference Type", '%1|%2', ItemReference2."Reference Type"::Customer, ItemReference2."Reference Type"::" ");
                    ItemReference2.SetFilter("Reference Type No.", '%1|%2', TransferHeader."RSMUS Customer No.", '');
                    ItemReference2.SetFilter("Reference No.", rec."RSMUS Item Reference No.");
                    If not ItemReference2.FindFirst()then Error('The following Item Reference is not valid for Item %1 for customer %2', rec."Item No.", TransferHeader."RSMUS Customer Name")
                    else If(rec."Item No." = '')then begin
                            rec.validate("Item No.", ItemReference2."Item No.");
                            rec.validate("Unit of Measure", ItemReference2."Unit of Measure");
                            rec."RSMUS Item Reference No.":=ItemReference2."Reference No.";
                            rec.Description:=ItemReference2.Description;
                            If "Line No." <> 0 then rec.Modify(false)
                            else
                                rec.Insert(false);
                        end;
                end;
            end;
        }
        //RSM10564 >>
        field(50102; RSMUSProdOrderCompStatus;Enum "Production Order Status")
        {
            Caption = 'Prod. Order Comp. Status';
        }
        field(50103; RSMUSProdOrderCompNo; Code[20])
        {
            Caption = 'Prod. Order Comp. No.';
        }
        field(50104; RSMUSProdOrderCompOrderLineNo; Integer)
        {
            Caption = 'Prod. Order Comp. Order Line No.';
        }
        field(50105; RSMUSProdOrderCompLineNo; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
        }
    }
    procedure TransferReferenceNoLookup(var TransferLine: Record "Transfer Line")
    var
        TransferHeader: record "Transfer Header";
    begin
        If TransferHeader.Get(TransferLine."Document No.")then TransferReferenceNoLookup(TransferLine, TransferHeader);
    end;
    procedure TransferReferenceNoLookup(var TransferLine: Record "Transfer Line"; TransferHeader: record "Transfer Header")
    var
        ItemReference2: Record "Item Reference";
    begin
        TransferLine.GetTransferHeader();
        ItemReference2.Reset();
        ItemReference2.SetCurrentKey("Reference Type", "Reference Type No.");
        ItemReference2.SetFilter("Reference Type", '%1|%2', ItemReference2."Reference Type"::Customer, ItemReference2."Reference Type"::" ");
        ItemReference2.SetFilter("Reference Type No.", '%1|%2', TransferHeader."RSMUS Customer No.", '');
        if PAGE.RunModal(PAGE::"Item Reference List", ItemReference2) = ACTION::LookupOK then begin
            TransferLine."RSMUS Item Reference No.":=ItemReference2."Reference No.";
            TransferLine."Unit of Measure":=ItemReference2."Unit of Measure";
            if(ItemReference2.Description <> '') or (ItemReference2."Description 2" <> '')then begin
                TransferLine.Description:=ItemReference2.Description;
                TransferLine."Description 2":=ItemReference2."Description 2";
            end;
        end;
    end;
}

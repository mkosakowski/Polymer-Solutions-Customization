codeunit 50105 "RSMUSCreateTransferOrders"
{
    //RSM10564 BJK 11/13/2022 BRD-0042: 7th Ave Transfer Process
    procedure BeginCreateTransferOrders(var TempProdOrderComponent: Record RSMUSTempProdOrderComponent)
    var
        ProdOrderComponent: Record "Prod. Order Component";
        TransferHeader: Record "Transfer Header";
        FirstLocationCode: Code[10];
        FirstTransferCode: Code[10];
        TransferValueFoundBool: Boolean;
    begin
        TransferValueFoundBool:=false;
        FirstLocationCode:='';
        CreatedTransferHeader:=false;
        GetNoSeriesCode();
        if TempProdOrderComponent.FindSet()then repeat if(TempProdOrderComponent."Location Code" = '') OR (TempProdOrderComponent.RSMUSTransferFromCode = '')then Error('Not all lines have locations');
                if FirstLocationCode = '' then begin
                    FirstLocationCode:=TempProdOrderComponent."Location Code";
                    FirstTransferCode:=TempProdOrderComponent.RSMUSTransferFromCode;
                    CreateTransferOrder(TempProdOrderComponent, TransferHeader);
                    CreatedTransferHeader:=true;
                end
                else
                begin
                    if(TempProdOrderComponent."Location Code" <> FirstLocationCode) OR (TempProdOrderComponent.RSMUSTransferFromCode <> FirstTransferCode)then Error('Not all lines have the same Location Code and Transfer From Code');
                end;
                if TempProdOrderComponent.RSMUSTransferValue <> 0 then TransferValueFoundBool:=true;
            until TempProdOrderComponent.Next() = 0;
        if not CreatedTransferHeader then Error('Could not create transfer order. Ensure Location Code and Transfer From fields are filled.');
        if not TransferValueFoundBool then Error('Transfer Order could not be created. No lines have a Transfer Value');
        if TempProdOrderComponent.FindSet()then repeat if CreateTransferLine(TempProdOrderComponent, TransferHeader)then begin
                    Clear(ProdOrderComponent);
                    if ProdOrderComponent.Get(TempProdOrderComponent.Status, TempProdOrderComponent."Prod. Order No.", TempProdOrderComponent."Prod. Order Line No.", TempProdOrderComponent."Line No.")then begin
                        ProdOrderComponent.Validate(RSMUSTransferOrderNo, TransferHeader."No.");
                        ProdOrderComponent.Modify();
                    end;
                    TempProdOrderComponent.Delete();
                end;
            until TempProdOrderComponent.Next() = 0;
        //Commit();
        Page.Run(Page::"Transfer Order", TransferHeader);
    end;
    procedure CreateTransferOrder(TempProdOrderComponent: Record RSMUSTempProdOrderComponent temporary; var TransferHeader: Record "Transfer Header")
    begin
        Clear(TransferHeader);
        TransferHeader.Init();
        NextHeaderNo:=GetNo();
        TransferHeader.Validate("No.", NextHeaderNo);
        TempProdOrderComponent.CalcFields(RSMUSTransferFromCode);
        TransferHeader.Validate("Transfer-from Code", TempProdOrderComponent.RSMUSTransferFromCode);
        TransferHeader.Validate("Transfer-to Code", TempProdOrderComponent."Location Code");
        TransferHeader.Validate("Shipment Date", WorkDate());
        TransferHeader.Validate("Posting Date", WorkDate());
        TransferHeader.Insert();
        CreatedTransferHeader:=true;
    end;
    procedure CreateTransferLine(TempProdOrderComponent: Record RSMUSTempProdOrderComponent temporary; TransferHeader: Record "Transfer Header"): Boolean var
        TransferLine: Record "Transfer Line";
        TransLine2: Record "Transfer Line";
        NextLineNo: Integer;
    begin
        if TempProdOrderComponent.RSMUSTransferValue = 0 then exit(false);
        Clear(TransferLine);
        Clear(TransLine2);
        TransLine2.SetFilter("Document No.", TransferHeader."No.");
        if TransLine2.FindLast()then NextLineNo:=TransLine2."Line No." + 10000
        else
            NextLineNo:=10000;
        TransferLine.Init();
        TransferLine.Validate("Document No.", TransferHeader."No.");
        TransferLine.Validate("Line No.", NextLineNo);
        TransferLine.Validate("Item No.", TempProdOrderComponent."Item No.");
        TransferLine.Validate(Quantity, TempProdOrderComponent.RSMUSTransferValue);
        TransferLine.Validate(RSMUSProdOrderCompStatus, TempProdOrderComponent.Status);
        TransferLine.Validate(RSMUSProdOrderCompNo, TempProdOrderComponent."Prod. Order No.");
        TransferLine.Validate(RSMUSProdOrderCompOrderLineNo, TempProdOrderComponent."Prod. Order Line No.");
        TransferLine.Validate(RSMUSProdOrderCompLineNo, TempProdOrderComponent."Line No.");
        TransferLine.Insert();
        exit(true);
    end;
    procedure GetNo(): Code[20]var
        NoSeriesMgtCU: Codeunit NoSeriesManagement;
        NextNo: Code[20];
    begin
        NextNo:=NoSeriesMgtCU.GetNextNo(NoSeriesCode, WorkDate(), true);
        exit(NextNo);
    end;
    procedure GetNoSeriesCode()
    var
        InventorySetup: Record "Inventory Setup";
    begin
        if InventorySetup.Get()then NoSeriesCode:=InventorySetup."Transfer Order Nos.";
    end;
    var NextHeaderNo: Code[20];
    NoSeriesCode: Code[20];
    CreatedTransferHeader: Boolean;
}

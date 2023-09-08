codeunit 50107 "RSMUSHelperFunctions"
{
    //RSM10333 BRK 12/15/22 BRD-0015: Add EOQ functionality
    procedure GetEOQ(RequisitionLine: Record "Requisition Line")Return: Decimal begin
        if RequisitionLine."Ref. Order Type" = RequisitionLine."Ref. Order Type"::Purchase then begin
            RequisitionLine.CalcFields(RSMUSEOQ);
            Return:=RequisitionLine.RSMUSEOQ;
        end;
    end;
}

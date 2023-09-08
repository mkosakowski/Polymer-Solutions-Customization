pageextension 50124 "RSMUS Document Attachments" extends "Document Attachment Details" //1173
{
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    procedure RSMUSOpenForRecRef(RecRef: RecordRef)
    var
        FieldRef1: FieldRef;
        RecNo: Code[20];
    begin
        Rec.Reset();
        FromRecRef:=RecRef;
        Rec.SetRange("Table ID", RecRef.Number);
        case RecRef.Number of DATABASE::"RSMUS DDMS Master": begin
            FieldRef1:=RecRef.Field(1);
            RecNo:=FieldRef1.Value;
            Rec.SetRange("No.", RecNo);
        end;
        end;
    end;
}

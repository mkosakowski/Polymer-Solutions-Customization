tableextension 50139 "RSMUSCompanyInformation" extends "Company Information" //79
{
    fields
    {
        field(50100; RSMUSEmergencyWithinUS; Text[30])
        {
            Caption = 'Emergency Within US/Canada';
        }
        field(50101; RSMUSEmergencyOutsideUS; Text[30])
        {
            Caption = 'Emergency Outside US/Canada';
        }
        field(50102; RSMUSAuthorizationForReturn; Blob)
        {
            Caption = 'Authorization for Return';
        }
        field(50103; RSMUSShippingCertification; Text[100])
        {
            Caption = 'Shipping Certification';
        }
        field(50104; RSMUSRevisionNo; Text[100])
        {
            Caption = 'Revision No.';
        }
        field(50105; RSMUSPackingSlipFooter; Text[200])
        {
            Caption = 'Packing Slip Footer Text';
        }
        field(50106; RSMUSEmergencyResponse; Text[100])
        {
            Caption = 'Emergency Response Contract No.';
        }
    }
    procedure SetAuthorizationText(AuthorizationTextNew: Text)
    var
        OutStream: OutStream;
    begin
        Clear(RSMUSAuthorizationForReturn);
        RSMUSAuthorizationForReturn.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(AuthorizationTextNew);
        Rec.Modify();
    end;
    procedure GetAuthorizationText()Return: Text var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields(RSMUSAuthorizationForReturn);
        RSMUSAuthorizationForReturn.CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), Return)then;
    //Message(ReadingDataSkippedMsg, Rec.FieldCaption(RSMUSAuthorizationForReturn));
    end;
}

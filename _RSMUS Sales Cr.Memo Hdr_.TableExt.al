tableextension 50127 "RSMUS Sales Cr.Memo Hdr" extends "Sales Cr.Memo Header" //114
{
    fields
    {
        field(50100; "RSMUS Final Destination"; Text[100])
        {
            Caption = 'Final Destination';
            DataClassification = ToBeClassified;
        }
    }
}

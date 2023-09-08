tableextension 50124 "RSMUS Item Ref" extends "Item Reference" //5777
{
    fields
    {
        field(50100; "RSMUS Specification Date"; Date)
        {
            Caption = 'Specification Date';
            DataClassification = ToBeClassified;
        }
        field(50101; "RSMUS Shelf Life"; DateFormula)
        {
            Caption = 'Shelf Life';
            DataClassification = ToBeClassified;
        }
    }
}

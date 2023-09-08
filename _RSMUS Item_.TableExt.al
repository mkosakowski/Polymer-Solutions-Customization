tableextension 50122 "RSMUS Item" extends Item //27
{
    fields
    {
        field(50100; "RSMUS Product Description"; Text[100])
        {
            Caption = 'Product Description';
            DataClassification = ToBeClassified;
        }
        field(50101; "RSMUS Shelf Life"; DateFormula)
        {
            Caption = 'Shelf Life';
            DataClassification = ToBeClassified;
        }
    }
}

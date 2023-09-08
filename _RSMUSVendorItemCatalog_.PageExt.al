pageextension 50120 "RSMUSVendorItemCatalog" extends "Vendor Item Catalog" //297
{
    layout
    {
        addafter("Vendor Item No.")
        {
            field("RSMUS COA Required"; Rec."RSMUS COA Required")
            {
                ApplicationArea = All;
            }
        }
    }
}

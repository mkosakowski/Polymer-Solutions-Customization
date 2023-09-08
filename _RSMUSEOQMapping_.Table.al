table 50107 "RSMUSEOQMapping"
{
    //RSM10333 BRK 12/15/22 BRD-0015: Add EOQ functionality
    Caption = 'EOQ';

    fields
    {
        field(1; ItemNo; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(2; ItemUoM; Code[10])
        {
            Caption = 'Item UOM';
            TableRelation = "Item Unit of Measure".Code where("Item No."=field(ItemNo));
        }
        field(3; VendorNo; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(4; LocationCode; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(10; EOQ; Decimal)
        {
            Caption = 'EOQ';
            DecimalPlaces = 0: 5;
        }
    }
    keys
    {
        key(Key1; ItemNo, ItemUOM, VendorNo, LocationCode)
        {
            Clustered = true;
        }
    }
}

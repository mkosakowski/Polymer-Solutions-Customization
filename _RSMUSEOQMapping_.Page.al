page 50107 "RSMUSEOQMapping"
{
    //RSM10333 BRK 12/15/22 BRD-0015: Add EOQ functionality
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RSMUSEOQMapping;
    Caption = 'EOQ Mapping';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(ItemNo; Rec.ItemNo)
                {
                    ApplicationArea = All;
                }
                field(ItemUOM; Rec.ItemUOM)
                {
                    ApplicationArea = All;
                }
                field(VendorNo; Rec.VendorNo)
                {
                    ApplicationArea = All;
                }
                field(LocationCode; Rec.LocationCode)
                {
                    ApplicationArea = All;
                }
                field(EOQ; Rec.EOQ)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

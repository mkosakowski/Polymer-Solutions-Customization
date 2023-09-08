pageextension 50130 "RSMUSIWXLicensePlate" extends "IWX License Plate" //23044510
{
    layout
    {
        addlast(General)
        {
            field(RSMUSProdOrderNo; Rec.RSMUSProdOrderNo)
            {
                ApplicationArea = All;
            }
            field(RSMUSSourceType; Rec.RSMUSSourceType)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RSMUSSourceNo; Rec.RSMUSSourceNo)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RSMUSDescription; Rec.RSMUSDescription)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}

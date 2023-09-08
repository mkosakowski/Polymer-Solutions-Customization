enum 50100 "RSMUS Confirmation Status"
{
    //RSM10220 MGZ 09/13/22 BRD-0006: PO Status Confirmation
    Extensible = true;

    value(0; Unconfirmed)
    {
    Caption = 'Unconfirmed';
    }
    value(1; Confirmed)
    {
    Caption = 'Confirmed';
    }
}

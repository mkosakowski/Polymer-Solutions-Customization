table 50104 "RSMUS DDMS Documents"
{
    //RSM10331 MGZ 09/16/22 BRD-0004: Genesis - Create RSMUS DDMS Documents Table for DDMS Documents action
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Caption = 'Invoice Routing Documents';

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(5; "Document Type"; Text[50])
        {
            Caption = 'Document Type';
            TableRelation = "RSMUS DDMS Document Type"."Document Type Name";
        }
        field(10; "Created By"; Text[50])
        {
            Caption = 'Created By';
        }
        field(11; "Sent Via Email"; Text[50])
        {
            Caption = 'Sent Via Email';
        }
        field(12; "Recipient Email"; Text[50])
        {
            Caption = 'Recipient Email';
            TableRelation = "RSMUS DDMS Recipient Emails"."Contact Email" where("Customer No."=field("Customer No."));
            ValidateTableRelation = false;
        }
        field(20; Quantity; Integer)
        {
            Caption = 'Qty of documents to be Couriered';
        }
        field(30; "Couriered to Freight Forwarder";Enum "RSMUS Couriered to Fght Frwrdr")
        {
            Caption = 'Couriered to Freight Forwarder';
        }
        field(31; "Freight Forwarder Type";Enum "RSMUS Freight Forwarder Type")
        {
            Caption = 'Freight Forwarder Type';
        }
        field(32; "Forward to Name"; Text[50])
        {
            Caption = 'Forward to Name';
        }
        field(33; "Recipient Name"; Text[100])
        {
            Caption = 'Recipient Name';
            FieldClass = FlowField;
            CalcFormula = lookup("RSMUS DDMS Recipient Emails"."Contact Name" where("Customer No."=field("Customer No.")));
        }
    }
    keys
    {
        key(PK; "Customer No.", "Document Type", "Created By", "Sent Via Email", "Recipient Email")
        {
            Clustered = true;
        }
    }
}

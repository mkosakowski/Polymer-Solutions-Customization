page 50102 "RSMUS DDMS Master"
{
    //RSM10331 MGZ 09/13/22 BRD-0004: Genesis - Create DDMS Master table for Foreign Trade
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Caption = 'Invoice Routing Master';
    PageType = Card;
    SourceTable = "RSMUS DDMS Master";
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                    Editable = false;
                }
                field(CustomerCountry; Rec.CustomerCountry)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Country field.';
                    Editable = false;
                }
                field(CustomerShipmentMethod; Rec.CustomerShipmentMethod)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Shipment Method field.';
                    Editable = false;
                }
            }
            group(Details)
            {
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notes field.';
                    MultiLine = true;
                    Width = 400;
                }
            }
            group("")
            {
                field("Recipient Address"; Rec."Recipient Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recepient Address field.';
                    MultiLine = true;
                    Width = 400;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(RSMUSDocuments)
            {
                Image = OpenWorksheet;
                Promoted = true;
                Caption = 'Documents';
                ToolTip = 'Lookup to the Invoice Routing Documents Record for the following Customer and Ship-To location';
                ApplicationArea = All;
                PromotedCategory = Process;
                RunObject = page "RSMUS DDMS Documents";
                RunPageLink = "Customer No."=field("Customer No.");
            }
            action(RSMUSRecipientEmails)
            {
                Image = Email;
                Promoted = true;
                Caption = 'Recipients';
                ToolTip = 'Lookup to the Invoice Routing Recipients Record for the following Customer and Ship-To location';
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = page "RSMUS DDMS Recipient Emails";
                RunPageLink = "Customer No."=field("Customer No.");
            }
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        RSMUSDDMSMaster: Record "RSMUS DDMS Master";
        Customer: Record Customer;
    begin
        //When coming from the Customer Card, default data on the DDMS Master record
        if not RSMUSDDMSMaster.Get(Rec."Customer No.")then begin
            if Customer.Get(Rec."Customer No.")then begin
                Rec.Init();
                Rec.Validate("Customer No.", Customer."No.");
                Rec.Validate(CustomerCountry, Customer."Country/Region Code");
                Rec.Validate(CustomerShipmentMethod, Customer."Shipment Method Code");
                Rec.Insert();
            end;
        end;
    end;
}

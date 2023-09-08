page 50104 "RSMUS DDMS Recipient Emails"
{
    //RSM10331 MGZ 09/28/22 BRD-0004: Genesis - Create RSMUS DDMS Recipient Email Page
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Caption = 'Invoice Routing Recipient Emails';
    PageType = List;
    SourceTable = "RSMUS DDMS Recipient Emails";
    UsageCategory = None;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Name field.';
                    Editable = false;
                }
                field("Contact Email"; Rec."Contact Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Email field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SelectEmailFromContacts)
            {
                ApplicationArea = All;
                Caption = 'Select Email from Contacts';
                ToolTip = 'Select an email address from the list of contacts.';
                Image = ContactFilter;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ContBusRel: Record "Contact Business Relation";
                begin
                    Rec.GetSendToEmailFromContactsSelection(ContBusRel."Link to Table"::Customer.AsInteger(), Rec.GetFilter("Customer No."));
                end;
            }
        }
    }
}

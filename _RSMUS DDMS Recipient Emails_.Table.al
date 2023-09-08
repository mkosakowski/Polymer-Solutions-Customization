table 50105 "RSMUS DDMS Recipient Emails"
{
    //RSM10331 MGZ 09/28/22 BRD-0004: Genesis - Create RSMUS DDMS Recipient Email Table
    //RSM10331 BRK 11/30/22 BRD-0004: Updates to rename DDMS to "Invoice Routing" and related to Customer as opposed to Customer and Ship-to Address
    Caption = 'Invoice Routing Recipient Emails';

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(2; ContactNo; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact."No.";

            trigger OnValidate()
            var
                lContact: Record Contact;
            begin
                if lContact.Get(Rec.ContactNo)then begin
                    Rec."Contact Name":=lContact.Name;
                    Rec."Contact Email":=lContact."E-Mail";
                end;
            end;
        }
        field(10; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
            TableRelation = Contact.Name;
            ValidateTableRelation = false;
        }
        field(11; "Contact Email"; Text[80])
        {
            Caption = 'Contact Email';
        }
    }
    keys
    {
        key(PK; "Customer No.", ContactNo)
        {
            Clustered = true;
        }
    }
    //Copied from TAB9657 "Custom Report Selection" v21.1 >>
    procedure GetSendToEmailFromContactsSelection(LinkType: Option; LinkNo: Code[20])
    var
        Contact: Record Contact;
        ContBusRel: Record "Contact Business Relation";
    begin
        ContBusRel.FindContactsByRelation(Contact, "Contact Business Relation Link to Table".FromInteger(LinkType), LinkNo);
        if IsCustomerVendorLinkType("Contact Business Relation Link to Table".FromInteger(LinkType))then GetCustomerVendorAdditionalContacts(Contact, "Contact Business Relation Link to Table".FromInteger(LinkType), LinkNo);
        if Contact.FindSet()then if Contact.GetContactsSelectionFromContactList(true)then GetSendToEmailFromContacts(Contact);
    end;
    local procedure IsCustomerVendorLinkType(LinkType: Enum "Contact Business Relation Link To Table"): Boolean begin
        exit((LinkType = LinkType::Customer) or (LinkType = LinkType::Vendor));
    end;
    local procedure GetCustomerVendorAdditionalContacts(var Contact: Record Contact; LinkType: Enum "Contact Business Relation Link To Table"; LinkNo: Code[20])
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        BillToPayToContact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        CVNo: Code[20];
    begin
        case LinkType of "Contact Business Relation Link To Table"::Customer: begin
            Customer.Get(LinkNo);
            if Customer.Get(Customer."Bill-to Customer No.")then CVNo:=Customer."No.";
        end;
        "Contact Business Relation Link To Table"::Vendor: begin
            Vendor.Get(LinkNo);
            if Vendor.Get(Vendor."Pay-to Vendor No.")then CVNo:=Vendor."No.";
        end;
        end;
        if ContactBusinessRelation.FindContactsByRelation(BillToPayToContact, LinkType, CVNo)then CombineContacts(Contact, BillToPayToContact);
    end;
    local procedure CombineContacts(var Contact: Record Contact; var BillToPayToContact: Record Contact)
    var
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        ContactNoFilter: Text;
    begin
        ContactNoFilter:=SelectionFilterManagement.GetSelectionFilterForContact(Contact);
        if ContactNoFilter <> '' then ContactNoFilter+='|' + SelectionFilterManagement.GetSelectionFilterForContact(BillToPayToContact)
        else
            ContactNoFilter:=SelectionFilterManagement.GetSelectionFilterForContact(BillToPayToContact);
        Contact.Reset();
        Contact.SetFilter("No.", ContactNoFilter);
    end;
    procedure GetSendToEmailFromContacts(var Contact: Record Contact)
    var
        RSMUSDDMSRecipientEmails: Record "RSMUS DDMS Recipient Emails";
        FieldLenghtExceeded: Boolean;
    begin
        //Modified to loop Contacts and insert new records to table
        if Contact.FindSet()then begin
            repeat if not RSMUSDDMSRecipientEmails.Get(Rec."Customer No.", Contact."No.")then begin
                    RSMUSDDMSRecipientEmails.Init();
                    RSMUSDDMSRecipientEmails.Validate("Customer No.", Rec."Customer No.");
                    RSMUSDDMSRecipientEmails.Validate(ContactNo, Contact."No.");
                    RSMUSDDMSRecipientEmails.Insert();
                end
                else
                begin
                    //Recipient Email record already exists, only update data
                    RSMUSDDMSRecipientEmails.Validate("Contact Name", Contact.Name);
                    RSMUSDDMSRecipientEmails.Validate("Contact Email", Contact."E-Mail");
                    RSMUSDDMSRecipientEmails.Modify();
                end;
            until(Contact.Next() = 0) or FieldLenghtExceeded;
        end;
    end;
//Copied from TAB9657 "Custom Report Selection" v21.1 <<
}

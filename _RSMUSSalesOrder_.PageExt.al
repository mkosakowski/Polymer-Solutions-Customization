pageextension 50113 "RSMUSSalesOrder" extends "Sales Order" //42
{
    layout
    {
        //RSM11084 >>
        addlast(General)
        {
            field(RSMUSCut; Rec.RSMUSCut)
            {
                ApplicationArea = All;
            }
            field(RSMUSBookingNo; Rec.RSMUSBookingNo)
            {
                ApplicationArea = All;
            }
            field(RSMUSBookingETA; Rec.RSMUSBookingETA)
            {
                ApplicationArea = All;
            }
            field(RSMUSERD; Rec.RSMUSERD)
            {
                ApplicationArea = All;
            }
        }
        //RSM11084 <<
        addlast("Shipping and Billing")
        {
            field("RSMUS Final Destination"; Rec."RSMUS Final Destination")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(SendEmailConfirmation)
        {
            ApplicationArea = All;

            trigger OnAfterAction()
            begin
                Clear(TempBlob);
                TempBlob.CreateInStream(AttachmentInStream, TextEncoding::UTF8);
                TempBlob.CreateOutStream(AttachmentOutStream, TextEncoding::UTF8);
                ReportLayoutSelection.SetTempLayoutSelected(CustomReportLayout.Code);
                Report.SaveAs(50100, '', ReportFormat::Pdf, AttachmentOutStream, RecRef);
                ReportLayoutSelection.SetTempLayoutSelected('');
                EmailMessage.AddAttachment('Terms&Conditions' + SalesHeader."No." + ',pdf', '.pdf', AttachmentInStream);
            end;
        }
        addlast("O&rder")
        {
            action(RSMUSDDMS)
            {
                ApplicationArea = All;
                Image = OpenWorksheet;
                Promoted = true;
                PromotedCategory = Category8;
                Caption = 'Invoice Routing';
                ToolTip = 'Lookup to the Invoice Routing Master record for the following Customer';

                trigger OnAction()
                var
                    lDDMSMaster: Record "RSMUS DDMS Master";
                    RSMUSDDMSMaster: Page "RSMUS DDMS Master";
                begin
                    if not lDDMSMaster.Get(Rec."Sell-to Customer No.")then Error('No Invoice Routing record exists for Customer %1.', Rec."Sell-to Customer No.")
                    else
                    begin
                        RSMUSDDMSMaster.Editable(false);
                        RSMUSDDMSMaster.SetRecord(lDDMSMaster);
                        RSMUSDDMSMaster.Run();
                    end;
                end;
            }
        }
    }
    var ReportLayoutSelection: Record "Report Layout Selection";
    CustomReportLayout: Record "Custom Report Layout";
    SalesHeader: Record "Sales Header";
    EmailMessage: Codeunit "Email Message";
    TempBlob: Codeunit "Temp Blob";
    RecRef: RecordRef;
    AttachmentOutStream: OutStream;
    AttachmentInStream: InStream;
}

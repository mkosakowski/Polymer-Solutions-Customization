reportextension 50103 "RSMUS Purch. Cr. Memo" extends "Purchase Credit Memo NA" //10120
{
    dataset
    {
        add("Purch. Cr. Memo Hdr.")
        {
            column(RSMUSCompanyPic; gCompany.Picture)
            {
            }
            column(RSMUSVendor_Cr__Memo_No_; "Vendor Cr. Memo No.")
            {
            }
        }
        modify("Purch. Cr. Memo Hdr.")
        {
        trigger OnAfterPreDataItem()
        begin
            if gCompany.Get()then gCompany.CalcFields(Picture);
        end;
        }
    }
    rendering
    {
        layout(PSGPurchCrMemo)
        {
            Caption = 'PSG Purchase Credit Memo';
            Summary = 'PSG Purchase Credit Memo';
            Type = RDLC;
            LayoutFile = './src/ReportExt/Layouts/Rep10120-Ext50103.RSMUSPurchCrMemo.rdl';
        }
    }
    var gCompany: Record "Company Information";
}

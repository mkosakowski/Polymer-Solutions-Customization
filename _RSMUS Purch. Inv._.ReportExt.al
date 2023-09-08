reportextension 50102 "RSMUS Purch. Inv." extends "Purchase Invoice NA" //10121
{
    dataset
    {
        add("Purch. Inv. Header")
        {
            column(RSMUSCompanyPic; gCompany.Picture)
            {
            }
        }
        modify("Purch. Inv. Header")
        {
        trigger OnAfterPreDataItem()
        begin
            if gCompany.Get()then gCompany.CalcFields(Picture);
        end;
        }
    }
    rendering
    {
        layout(PSGPurchInvoice)
        {
            Caption = 'PSG Purchase Invoice';
            Summary = 'PSG Purchase Invoice';
            Type = RDLC;
            LayoutFile = './src/ReportExt/Layouts/Rep10121-Ext50102.RSMUSPurchInv.rdl';
        }
    }
    var gCompany: Record "Company Information";
}

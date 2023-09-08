reportextension 50100 "RSMUSCheckStubCheckStub" extends "Check (Stub/Check/Stub)" //10411
{
    //RSM11216 BH 01/27/2023 BRD-0045 Check Modification
    rendering
    {
        layout(PSGCheckLayout)
        {
            Caption = 'PSG Check Layout';
            Summary = 'PSG Check Layout';
            Type = RDLC;
            LayoutFile = './src/ReportExt/Layouts/Rep10411-Ext50100.RSMUSCheckStubCheckStub.rdl';
        }
    }
}

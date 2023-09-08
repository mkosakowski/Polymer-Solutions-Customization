codeunit 50100 "RSMUSExtensionInstall"
{
    //RSM0001 BH 11/18/2019 Created report selection settings
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        //Set report selections for our custom reports
        SetReportSelection("Report Selection Usage"::"S.Quote", 50102);
        SetReportSelection("Report Selection Usage"::"S.Order", 50103);
        SetReportSelection("Report Selection Usage"::"S.Invoice", 50104);
        SetReportSelection("Report Selection Usage"::"S.Return", 50105);
        SetReportSelection("Report Selection Usage"::"V.Remittance", 50106);
        SetReportSelection("Report Selection Usage"::"S.Cr.Memo", 50109);
        //Set report selections for our report extensions
        SetReportSelection("Report Selection Usage"::"P.Cr.Memo", 10120);
        UpdateTenantLayoutSelection(10120, 'PSGPurchCrMemo');
        SetReportSelection("Report Selection Usage"::"P.Invoice", 10121);
        UpdateTenantLayoutSelection(10121, 'PSGPurchInvoice');
        SetReportSelection("Report Selection Usage"::"P.Order", 10122);
        UpdateTenantLayoutSelection(10122, 'PSGPurchOrder');
        SetReportSelection("Report Selection Usage"::"B.Check", 10411);
        UpdateTenantLayoutSelection(10411, 'PSGCheckLayout');
    end;
    local procedure SetReportSelection(UsageOption: Enum "Report Selection Usage"; ReportId: Integer)
    var
        ReportSelections: Record "Report Selections";
    begin
        ReportSelections.Reset();
        ReportSelections.SetRange(Usage, UsageOption);
        if ReportSelections.FindFirst()then begin
            ReportSelections.Validate("Report ID", ReportId);
            ReportSelections.Modify(true);
        end;
    end;
    local procedure UpdateTenantLayoutSelection(ReportId: Integer; LayoutName: Text[250])
    var
        ReportLayoutList: Record "Report Layout List";
        TenantReportLayoutSelection: Record "Tenant Report Layout Selection";
        AppInfo: ModuleInfo;
        EmptyGuid: Guid;
    begin
        //LayoutName = Layout name from rendering section
        // rendering
        // {
        //      layout(RSMUSSalesInvoice)
        //      {
        //          Caption = 'Client Custom Sales Invoice';
        //          Type = RDLC;
        //          LayoutFile = './src/ReportExt/Layouts/Rep1306-Ext50100.RSMUSSalesInvoice.rdl';
        //      }
        // }
        NavApp.GetCurrentModuleInfo(AppInfo);
        ReportLayoutList.Reset();
        ReportLayoutList.SetRange("Application ID", AppInfo.Id);
        ReportLayoutList.SetRange("Report ID", ReportId);
        ReportLayoutList.SetRange(Name, LayoutName);
        if ReportLayoutList.FindFirst()then begin
            TenantReportLayoutSelection."App ID":=ReportLayoutList."Application ID";
            TenantReportLayoutSelection."Company Name":=CopyStr(CompanyName(), 1, 30);
            TenantReportLayoutSelection."Layout Name":=ReportLayoutList.Name;
            TenantReportLayoutSelection."Report ID":=ReportLayoutList."Report ID";
            TenantReportLayoutSelection."User ID":=EmptyGuid;
            if not TenantReportLayoutSelection.Insert(true)then TenantReportLayoutSelection.Modify(true);
        end;
    end;
/*
        NOTE: If report selection is not available you can use the following event subscriber to force in a custom report

        [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
        local procedure OnAfterSubstituteReport(ReportId: Integer; var NewReportId: Integer)
        begin
            if ReportId = Report::"Outstanding Sales Order Status" then
                NewReportId := Report::"RSMUSOutstanding SO Status";
        end;
    */
}

codeunit 50101 "RSMUSCopyDimensionsAndValues"
{
    //RSM10243 BRK 08/22/2022 BRD-0029: Genesis of Dimension and Dimension Value company copy
    //RSM10539 BRK 11/30/2022 BRD-0041: Update BRD-0029 code to run over all Dimensions
    trigger OnRun()
    begin
        Code();
    end;
    local procedure Code()
    var
        lCompanies: Record Company;
        LocalCompanyDimension: Record Dimension;
        OtherCompanyDimension: Record Dimension;
        lAccessibleCompaniesDim: Page RSMUSAccessibleCompaniesDim;
    begin
        lAccessibleCompaniesDim.LookupMode:=true;
        if lAccessibleCompaniesDim.RUNMODAL() = Action::LookupOK then begin
            lCompanies.Reset();
            lCompanies.SetFilter(Name, '<>%1', CompanyName());
            if lCompanies.FindSet()then repeat if OtherCompanyDimension.ChangeCompany(lCompanies.Name)then begin
                        //RSM10539 >>
                        LocalCompanyDimension.Reset();
                        if LocalCompanyDimension.FindSet()then repeat if not OtherCompanyDimension.Get(LocalCompanyDimension.Code)then begin
                                    //Doesn't exist, create new in other company
                                    CreateDimensionToNewCompany(OtherCompanyDimension, LocalCompanyDimension);
                                    OtherCompanyDimension.Blocked:=IsBlocked(lCompanies.Name);
                                    OtherCompanyDimension.Insert();
                                end
                                else
                                begin
                                    //Exists, simply update blocked status
                                    OtherCompanyDimension.Blocked:=IsBlocked(lCompanies.Name);
                                    OtherCompanyDimension.Modify();
                                end;
                                CopyDimensionValues(LocalCompanyDimension.Code, lCompanies.Name);
                            until LocalCompanyDimension.Next() = 0;
                    //RSM10539 <<
                    end;
                until lCompanies.Next() = 0;
            Message('Dimensions and dimension values copied to all other companies');
        end;
    end;
    local procedure CopyDimensionValues(DimensionCode: Code[20]; CompanyNameParam: Text[30])
    var
        CurrentCompanyDimensionValue: Record "Dimension Value";
        OtherCompanyDimensionValue: Record "Dimension Value";
    begin
        CurrentCompanyDimensionValue.Reset();
        CurrentCompanyDimensionValue.SetRange("Dimension Code", DimensionCode);
        if CurrentCompanyDimensionValue.FindSet()then begin
            repeat if OtherCompanyDimensionValue.ChangeCompany(CompanyNameParam)then begin
                    if not OtherCompanyDimensionValue.Get(DimensionCode, CurrentCompanyDimensionValue.Code)then begin
                        //Doesn't exist, create new in other company
                        CreateDimensionValueToNewCompany(OtherCompanyDimensionValue, CurrentCompanyDimensionValue);
                        OtherCompanyDimensionValue.Blocked:=IsBlocked(CompanyNameParam);
                        OtherCompanyDimensionValue.Insert();
                    end
                    else
                    begin
                        //Exists, simply update blocked status
                        OtherCompanyDimensionValue.Blocked:=IsBlocked(CompanyNameParam);
                        OtherCompanyDimensionValue.Modify();
                    end;
                end;
            until CurrentCompanyDimensionValue.Next() = 0;
        end;
    end;
    local procedure IsBlocked(CompanyNameParam: Text[30]): Boolean var
        RSMUSBlockedDimension: Record RSMUSBlockedDimension;
    begin
        RSMUSBlockedDimension.Reset();
        RSMUSBlockedDimension.SetRange(Company, CompanyNameParam);
        exit(not RSMUSBlockedDimension.IsEmpty()); //Existance in this table means Blocked
    end;
    local procedure CreateDimensionToNewCompany(var OtherCompanyDimension: Record Dimension; var CurrentCompanyDimension: Record Dimension)
    begin
        OtherCompanyDimension.Init();
        OtherCompanyDimension.TransferFields(CurrentCompanyDimension);
    end;
    local procedure CreateDimensionValueToNewCompany(var OtherCompanyDimensionValue: Record "Dimension Value"; var CurrentCompanyDimensionValue: Record "Dimension Value")
    begin
        OtherCompanyDimensionValue.Init();
        OtherCompanyDimensionValue.TransferFields(CurrentCompanyDimensionValue);
    end;
}

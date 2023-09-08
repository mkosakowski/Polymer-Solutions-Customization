pageextension 50116 "RSMUSDimensions" extends Dimensions //536
{
    actions
    {
        addlast(processing)
        {
            action(RSMUSCopyDimensionToCompanies)
            {
                ApplicationArea = All;
                Caption = 'Push to Companies';
                Image = Company;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RSMUSCopyDimensionsAndValues: Codeunit RSMUSCopyDimensionsAndValues;
                begin
                    RSMUSCopyDimensionsAndValues.Run();
                end;
            }
        }
    }
}

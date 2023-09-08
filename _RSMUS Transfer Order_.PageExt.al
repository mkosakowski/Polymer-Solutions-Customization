pageextension 50109 "RSMUS Transfer Order" extends "Transfer Order" //5740
{
    layout
    {
        addlast(General)
        {
            field("RSMUSExternal Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
            field("RSMUS Customer No."; Rec."RSMUS Customer No.")
            {
                ApplicationArea = All;
            }
            field("RSMUS Customer Name"; Rec."RSMUS Customer Name")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action(RSMUSPrint)
            {
                ApplicationArea = All;
                Caption = 'Print Consign Transfer Order';
                Promoted = true;
                PromotedCategory = Category8;
                Ellipsis = true;

                trigger OnAction()
                var
                    TransHeader: Record "Transfer Header";
                begin
                    CurrPage.SetSelectionFilter(TransHeader);
                    Report.Run(Report::"RSMUS Consign Transfer", true, true, TransHeader);
                end;
            }
        }
    }
}

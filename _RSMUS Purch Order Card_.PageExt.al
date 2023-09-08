pageextension 50115 "RSMUS Purch Order Card" extends "Purchase Order" //50
{
    layout
    {
        addlast(General)
        {
            field("RSMUS Confirmation Status"; Rec."RSMUS Confirmation Status")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    If xrec."RSMUS Confirmation Status" = xrec."RSMUS Confirmation Status"::Confirmed then begin
                        If Confirm('Do you want to change confirmation status?', true)then rec."RSMUS Confirmation Status":=rec."RSMUS Confirmation Status"::UnConfirmed
                        else
                            rec."RSMUS Confirmation Status":=rec."RSMUS Confirmation Status"::Confirmed;
                        rec.Modify(false);
                        exit end;
                    If xrec."RSMUS Confirmation Status" = xrec."RSMUS Confirmation Status"::UnConfirmed then begin
                        If Confirm('Confirm Purchase Order?', true)then rec."RSMUS Confirmation Status":=rec."RSMUS Confirmation Status"::Confirmed
                        else
                            rec."RSMUS Confirmation Status":=rec."RSMUS Confirmation Status"::UnConfirmed;
                        rec.Modify(false);
                        exit end;
                end;
            }
            field("RSMUS Pickup No."; Rec."RSMUS Pickup No.")
            {
                ApplicationArea = All;
            }
            field("RSMUS COA Required"; Rec."RSMUS COA Required")
            {
                ApplicationArea = All;
            }
        }
        addlast("Shipping and Payment")
        {
            field("RSMUS Shipping Agent Code"; Rec."RSMUS Shipping Agent Code")
            {
                ApplicationArea = All;
                Caption = 'Shipping Agent';

                trigger OnValidate()
                begin
                    Rec.CalcFields("RSMUS Ship Agent Account No.");
                end;
            }
            field("RSMUS Ship Agent Account No."; Rec."RSMUS Ship Agent Account No.")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        lPurchLine: Record "Purchase Line";
    begin
        lPurchLine.SetRange("Document No.", rec."No.");
        If lPurchLine.IsEmpty() and (rec."RSMUS COA Required" = true)then begin
            rec."RSMUS COA Required":=false;
            rec.Modify(false);
            CurrPage.Update(false);
        end;
    end;
}

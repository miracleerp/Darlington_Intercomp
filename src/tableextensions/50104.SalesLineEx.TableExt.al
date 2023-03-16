tableextension 50104 "SalesLineEx" extends "Sales Line"
{
    fields
    {
        field(50100; LotNo; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Lot No.';
        }
    }
    var myInt: Integer;
    local procedure UpdateSaleLineQty()
    var
        PurchaseOrderRecord: Record "Purchase Header";
        PurchaseLineRecord: Record "Purchase Line";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetFilter("No.", '=%1', rec."Document No.");
        if SalesHeader.FindSet then begin
            PurchaseLineRecord.SetFilter("Document No.", '=%1', SalesHeader."Your Reference");
            if PurchaseLineRecord.FindSet then begin
                PurchaseLineRecord.SetFilter("No.", '=%1', rec."No.");
                if PurchaseLineRecord.FindSet then begin
                    PurchaseLineRecord.SetFilter("Line No.", '=%1', rec."Line No.");
                    if PurchaseLineRecord.FindSet then begin
                        if PurchaseLineRecord.Quantity <> rec.Quantity then begin
                            PurchaseLineRecord.Validate(Quantity, rec.Quantity);
                            PurchaseLineRecord.Modify;
                        end
                        else
                            exit;
                    end;
                end;
            end;
        end;
    end;
    trigger OnAfterModify()
    begin
        UpdateSaleLineQty();
    end;
}

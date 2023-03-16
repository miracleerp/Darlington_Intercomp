tableextension 50105 "PurchaseLineEx" extends "Purchase Line"
{
    fields
    {
    }
    var myInt: Integer;
    local procedure UpdatePurchaseLineQty()
    var
        SalesOrderRecord: Record "Sales Header";
        SalesLineRecord: Record "Sales Line";
        PurchaseHeader: Record "Purchase Header";
    begin
        if rec.Modify then begin
            SalesOrderRecord.SetFilter("Your Reference", '=%1', rec."Document No.");
            if SalesOrderRecord.FindSet then begin
                SalesLineRecord.SetFilter("Document No.", '=%1', SalesOrderRecord."No.");
                if SalesLineRecord.FindSet then begin
                    SalesLineRecord.SetFilter("No.", '=%1', rec."No.");
                    if SalesLineRecord.FindSet then begin
                        SalesLineRecord.SetFilter("Line No.", '=%1', rec."Line No.");
                        if SalesLineRecord.FindSet then begin
                            if SalesLineRecord.Quantity <> rec.Quantity then begin
                                SalesLineRecord.Validate(Quantity, rec.Quantity);
                                SalesLineRecord.Modify;
                            end
                            else
                                exit;
                        end;
                    end;
                end;
            end;
        end;
    end;
    trigger OnAfterModify()
    var
        myInt: Integer;
    begin
        UpdatePurchaseLineQty();
    end;
}

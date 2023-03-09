codeunit 50110 TransferFieldsCU
{
    Permissions = TableData "Purch. Inv. Header"=rm;
    TableNo = "Purch. Inv. Header";

    var myInt: Integer;
    procedure TransferFieldsFromPO(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        purchaseOrderRec: Record "Purchase Header";
        TransField: Codeunit 80;
    begin
        PurchInvHeader.Init();
        PurchInvHeader.TransferFields(purchaseOrderRec);
        PurchInvHeader.Modify;
    end;
}

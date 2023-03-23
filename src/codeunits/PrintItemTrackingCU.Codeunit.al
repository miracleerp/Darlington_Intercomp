codeunit 50111 "PrintItemTrackingCU"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment + Print", 'OnAfterCode', '', false, false)]
    local procedure printItemTrackingLines()
    var
        ItemTrackingReport: Report PostedItemTrackingLines;
        itemLedgerEntry: Record "Item Ledger Entry";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        itemLedgerEntry.SetFilter("Entry Type", '=%1', itemLedgerEntry."Entry Type"::Sale);
        if itemLedgerEntry.FindLast then begin
            itemLedgerEntry.SetFilter("Document No.", '=%1', itemLedgerEntry."Document No.");
            if itemLedgerEntry.FindSet then begin
                ItemTrackingReport.SetTableView(itemLedgerEntry);
                ItemTrackingReport.Run();
            end;
        end;
    end;
    trigger OnRun()
    begin
    end;
}

pageextension 50111 PostedSalesShipmentEx extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipment Date")
        {
            field(Customer_PO; rec.Customer_PO)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter("&Shipment")
        {
            action("Darlington Posted Shipment")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Darlington Posted Shipment';
                ToolTip = 'Print Darlington Posted Shipment';
                Image = PrintReport;

                trigger OnAction();
                var
                    SalesShipHeader: Record "Sales Shipment Header";
                    MyReport: Report "DarlingPostedShip";
                begin
                    SalesShipHeader:=Rec;
                    CurrPage.SetSelectionFilter(SalesShipHeader);
                    MyReport.SetTableView(SalesShipHeader);
                    MyReport.Run();
                    PrintItemTrackingLinesReport();
                end;
            }
        }
        modify("&Print")
        {
            trigger OnAfterAction()
            var
                PostedItemTrackingLines: Report PostedItemTrackingLines;
            begin
                PrintItemTrackingLinesReport();
            end;
        }
    }
    procedure PrintItemTrackingLinesReport()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedItemTrackingLines: Report PostedItemTrackingLines;
    begin
        ItemLedgerEntry.SetFilter("Document No.", '=%1', rec."No.");
        if ItemLedgerEntry.FindSet then begin
            PostedItemTrackingLines.SetTableView(ItemLedgerEntry);
            PostedItemTrackingLines.Run();
        end;
    end;
}

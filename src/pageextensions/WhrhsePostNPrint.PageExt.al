pageextension 60001 "WhrhsePostNPrint" extends "Warehouse Shipment"
{
    actions
    {
        addlast("P&osting")
        {
            action("Darlington Post & Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Darlington Posted Shipment';
                ToolTip = 'Print Darlington Posted Shipment';
                Image = PrintReport;

                trigger OnAction();
                var
                    WareShipHeader: Record "Warehouse Shipment Header";
                    MyReport: Report "DarlingPostedShip";
                begin
                    WareShipHeader:=Rec;
                    CurrPage.SetSelectionFilter(WareShipHeader);
                    MyReport.SetTableView(WareShipHeader);
                    MyReport.Run();
                end;
            }
        }
    }
}

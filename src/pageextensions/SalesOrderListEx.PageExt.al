pageextension 50122 "SalesOrderListEx" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name")
        {
            field(Customer_PO; rec.Customer_PO)
            {
                ApplicationArea = All;
            }
            field(BakeWeek; rec.BakeWeek)
            {
                ApplicationArea = All;
            }
        }
    }
    var myInt: Integer;
}

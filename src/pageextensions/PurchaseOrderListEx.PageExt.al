pageextension 50121 PurchaseOrderListEx extends "Purchase Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Vendor Name")
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

pageextension 50124 "PostedPurchaseInvList" extends "Posted Purchase Invoices"
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
    var
        myInt: Integer;
}

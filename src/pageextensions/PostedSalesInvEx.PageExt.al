pageextension 50112 "PostedSalesInvEx" extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter(Closed)
        {
            field(Customer_PO; rec.Customer_PO)
            {
                ApplicationArea = All;
                Editable = false;
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

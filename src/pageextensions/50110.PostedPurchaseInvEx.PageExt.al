pageextension 50110 "PostedPurchaseInvEx" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("IRS 1099 Code")
        {
            field(BillToCustomer; rec.BillToCustomer)
            {
                ApplicationArea = All;
            }
            field(BillToName; rec.BillToName)
            {
                ApplicationArea = All;
            }
            field(BillToAddress; rec.BillToAddress)
            {
                ApplicationArea = All;
            }
            field(BillToAddress2; rec.BillToAddress2)
            {
                ApplicationArea = All;
            }
            field(BillToCity; rec.BillToCity)
            {
                ApplicationArea = All;
            }
            field(BillToState; rec.BillToState)
            {
                ApplicationArea = All;
            }
            field(BillToZipCode; rec.BillToZipCode)
            {
                ApplicationArea = All;
            }
            field(BillToCountry; rec.BillToCountry)
            {
                ApplicationArea = All;
            }
            field(BillToContact; rec.BillToContact)
            {
                ApplicationArea = All;
            }
        }
        addafter(Corrective)
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

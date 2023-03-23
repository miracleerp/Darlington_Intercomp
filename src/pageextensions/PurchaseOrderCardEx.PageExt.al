pageextension 50109 "PurchaseOrderCardEx" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("Customer PO"; Rec.Customer_PO)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer PO Number';
                ToolTip = 'Here is where you manually enter the Customer PO Number';
            }
        }
        // Add changes to page layout here
        addafter(PayToOptions)
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
    }
    actions
    {
        // Add changes to page actions here
        addlast(Documents)
        {
            //Relate -> Documents -> Purchase Order
            action("Sales Order")
            {
                ApplicationArea = Basic;
                Image = SalesInvoice;

                trigger OnAction()
                var
                    SalesOrderPage: Page "Sales Order";
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.SetFilter("No.", '=%1', rec."Payment Reference");
                    if SalesHeader.FindSet then begin
                        SalesOrderPage.SetRecord(SalesHeader);
                        SalesOrderPage.Run();
                    end;
                end;
            }
        }
    }
    var myInt: Integer;
}

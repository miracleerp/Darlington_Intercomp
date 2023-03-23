codeunit 50101 "Miracle Fixes"
{
    Permissions = tabledata "Sales Shipment Header" = rimd;


    procedure UpdateBOLFields()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        if SalesShipmentHeader.Findset() then
            repeat
                SalesInvoiceHeader.SetRange("External Document No.", SalesShipmentHeader."External Document No.");
                if SalesInvoiceHeader.FindFirst() then begin
                    SalesShipmentHeader.BOL_BillToAddress := SalesInvoiceHeader.BOL_BillToAddress;
                    SalesShipmentHeader.BOL_BillToAddress2 := SalesInvoiceHeader.BOL_BillToAddress2;
                    SalesShipmentHeader.BOL_BillToCity := SalesInvoiceHeader.BOL_BillToCity;
                    SalesShipmentHeader.BOL_BillToContact := SalesInvoiceHeader.BOL_BillToContact;
                    SalesShipmentHeader.BOL_BillToCountry := SalesInvoiceHeader.BOL_BillToCountry;
                    SalesShipmentHeader.BOL_BillToCustomer := SalesInvoiceHeader.BOL_BillToCustomer;
                    SalesShipmentHeader.BOL_BillToName := SalesInvoiceHeader.BOL_BillToName;
                    SalesShipmentHeader.BOL_BillToState := SalesInvoiceHeader.BOL_BillToState;
                    SalesShipmentHeader.BOL_BillToZipCode := SalesInvoiceHeader.BOL_BillToZipCode;
                    SalesShipmentHeader.BakeWeek := SalesInvoiceHeader.BakeWeek;
                    SalesShipmentHeader.Modify();
                end;
            until SalesShipmentHeader.Next() = 0;
    end;
}

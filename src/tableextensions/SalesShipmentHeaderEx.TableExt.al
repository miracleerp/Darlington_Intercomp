tableextension 50109 SalesShipmentHeaderEx extends "Sales Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(99500; "Customer_PO"; text[300])
        {
            Caption = 'Customer_PO_Number';
            ExtendedDatatype = URL;
        }
    }
    var myInt: Integer;
    trigger OnInsert()
    var
        TransFieldCU: Codeunit TransferFieldsCU;
    begin
        TransferFields(Rec);
    end;
}

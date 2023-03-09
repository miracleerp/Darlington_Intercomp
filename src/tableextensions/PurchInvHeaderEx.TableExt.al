tableextension 50108 PurchInvHeaderEx extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here
        field(50100; BillToCustomer; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Customer';
        }
        field(50101; BillToName; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Name';
        }
        field(50102; BillToAddress; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Address';
        }
        field(50103; BillToAddress2; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Address 2';
        }
        field(50104; BillToCity; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to City';
        }
        field(50105; BillToState; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to State';
        }
        field(50106; BillToZipCode; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Zip Code';
        }
        field(50107; BillToCountry; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Country/Region';
        }
        field(50108; BillToContact; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Contact';
        }
        field(99500; "Customer_PO"; text[300])
        {
            Caption = 'Customer_PO_Number';
            ExtendedDatatype = URL;
        }
        field(50110; BakeWeek; Integer)
        {
            Caption = 'Bake Week';
        }
    }
    var trigger OnInsert()
    var
        TransFieldCU: Codeunit TransferFieldsCU;
    begin
        TransferFields(Rec);
    end;
}

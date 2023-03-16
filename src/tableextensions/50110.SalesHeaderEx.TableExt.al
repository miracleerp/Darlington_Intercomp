tableextension 50110 "SalesHeaderEx" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50101; BOL_BillToCustomer; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'BOL Bill to Customer';
        }
        field(50102; BOL_BillToName; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'BOL Bill to Name';
        }
        field(50103; BOL_BillToAddress; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'BOL Bill to Address';
        }
        field(50104; BOL_BillToAddress2; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'BOL Bill to Address 2';
        }
        field(50105; BOL_BillToCity; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'BOL Bill to City';
        }
        field(50106; BOL_BillToState; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'BOL Bill to State';
        }
        field(50107; BOL_BillToZipCode; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'BOL Bill to Zip Code';
        }
        field(50108; BOL_BillToCountry; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'BOL Bill to Country/Region';
        }
        field(50109; BOL_BillToContact; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'BOL Bill to Contact';
        }
        field(99500; "Customer_PO"; text[300])
        {
            Caption = 'Customer_PO_Number';
            ExtendedDatatype = URL;
        }
    }
    var myInt: Integer;
}

pageextension 50104 SalesOrderCardEx extends "Sales Order"
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
        addafter("Shipping and Billing")
        {
            group("BOL Bill-To")
            {
                field(BOL_BillToCustomer; rec.BOL_BillToCustomer)
                {
                    ApplicationArea = All;
                }
                field(BOL_BillToName; rec.BOL_BillToName)
                {
                    ApplicationArea = All;
                }
                field(BOL_BillToAddress; rec.BOL_BillToAddress)
                {
                    ApplicationArea = All;
                }
                field(BOL_BillToAddress2; rec.BOL_BillToAddress2)
                {
                    ApplicationArea = All;
                }
                field(BOL_BillToCity; rec.BOL_BillToCity)
                {
                    ApplicationArea = All;
                }
                field(BOL_BillToState; rec.BOL_BillToState)
                {
                    ApplicationArea = All;
                }
                field(BOL_BillToZipCode; rec.BOL_BillToZipCode)
                {
                    ApplicationArea = All;
                }
                field(BOL_BillToCountry; rec.BOL_BillToCountry)
                {
                    ApplicationArea = All;
                }
                field(BOL_BillToContact; rec.BOL_BillToContact)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        // Actions -> Functions -> Create Purchase Order
        addafter("Create Purchase Document")
        {
            action("Create HS Baking PO")
            {
                ApplicationArea = Basic;
                Image = CreateDocument;

                trigger OnAction()
                var
                    POHeader: Record "Purchase Header";
                begin
                    if rec."Your Reference" <> '' then begin
                        POHeader.SetFilter("No.", '=%1', rec."Your Reference");
                        if POHeader.FindSet then begin
                            Message('PO Already Exist, PO No. is %1', rec."Your Reference");
                        end
                        else
                            //Call CreatePOHeader()                
                            CreatePOHeader();
                    end
                    else
                        //Call CreatePOHeader()                
                        CreatePOHeader();
                end;
            }
        }
        addafter(Invoices)
        {
            //Relate -> Documents -> Purchase Order
            action("Purchase Order")
            {
                ApplicationArea = Basic;
                Image = PurchaseInvoice;

                trigger OnAction()
                var
                    PurchaseOrderPage: Page "Purchase Order";
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.SetFilter("No.", '=%1', rec."Your Reference");
                    if PurchaseHeader.FindSet then begin
                        PurchaseOrderPage.SetRecord(PurchaseHeader);
                        PurchaseOrderPage.Run();
                    end;
                end;
            }
        }
    }
    var myInt: Integer;
    //Procedure creates PO Header
    local procedure CreatePOHeader()
    var
        createPO: Record "Purchase Header";
        PurchaseOrderPage: Page "Purchase Order";
        PurchaseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DropShipLocation: Record Location;
    begin
        createPO.Init();
        if createPO."No." = '' then begin
            PurchaseSetup.Get();
            PurchaseSetup.TestField("Order Nos.");
            NoSeriesMgt.InitSeries(PurchaseSetup."Order Nos.", xRec."No. Series", 0D, createPO."No.", createPO."No. Series");
        end;
        createPO."Document Type":=createPO."Document Type"::Order;
        createPO.Validate("Posting Date", WorkDate());
        rec.Validate("Your Reference", createPO."No.");
        createPO.Validate("Payment Reference", rec."No.");
        createPO.validate(Customer_PO, rec.Customer_PO);
        createPO.Validate(BakeWeek, rec.BakeWeek);
        createPO.Validate(BilltoCustomer, rec."Bill-to Customer No.");
        createPO.Validate(BilltoName, rec."Bill-to Name");
        createPO.Validate(BillToAddress, rec."Bill-to Address");
        createPO.Validate(BillToAddress2, rec."Bill-to Address 2");
        createPO.Validate(BillToCity, rec."Bill-to City");
        createPO.Validate(BillToState, rec."Bill-to County");
        createPO.Validate(BillToZipCode, rec."Bill-to Post Code");
        createPO.Validate(BillToCountry, rec."Bill-to Country/Region Code");
        //The following line of code, checks the location table to see if the "Use for Drop Ship" option is enabled and vendor is selected to create a PO
        DropShipLocation.Get(rec."Location Code");
        if DropShipLocation.DropShipLocation then begin
            createPO.Validate("Buy-from Vendor No.", DropShipLocation.Vendor);
        end;
        createPO.Validate("Sell-to Customer No.", rec."Sell-to Customer No.");
        if rec."Ship-to Code" <> '' then begin
            createPO.Validate("Ship-to Code", rec."Ship-to Code");
        end;
        createPO.SetShipToAddress(rec."Ship-to Name", rec."Ship-to Name 2", rec."Ship-to Address", rec."Ship-to Address 2", rec."Ship-to City", rec."Ship-to Post Code", rec."Ship-to County", rec."Ship-to Country/Region Code");
        if createPO.Insert()then begin
            CreatePurchaseLines(createPO);
            PurchaseOrderPage.SetRecord(createPO);
            PurchaseOrderPage.Run();
        end;
    end;
    //Procedure creates PO Lines
    local procedure CreatePurchaseLines(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetFilter("Document No.", '=%1', rec."No.");
        if SalesLine.FindSet then begin
            repeat PurchaseLine.Init();
                PurchaseLine.Validate("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.Validate("Document No.", PurchaseHeader."No.");
                PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
                PurchaseLine.Validate("No.", SalesLine."No.");
                PurchaseLine.Validate("Line No.", SalesLine."Line No.");
                PurchaseLine.Validate(Quantity, SalesLine.Quantity);
                PurchaseLine.Validate("Location Code", rec."Location Code");
                PurchaseLine.Insert;
            until SalesLine.Next = 0;
        end;
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean var
        SalesHeaderRec: Record "Sales Header";
        POHeaderRec: Record "Purchase Header";
        InterCompanyPartner: Record "IC Partner";
    begin
        InterCompanyPartner.SetFilter(Code, '=%1', 'DCC');
        if InterCompanyPartner.FindSet then begin
            InterCompanyPartner.Get(InterCompanyPartner.Code);
            POHeaderRec.ChangeCompany(InterCompanyPartner."Inbox Details");
            POHeaderRec.SetFilter("No.", '=%1', rec."External Document No.");
            if POHeaderRec.FindSet then begin
                if rec."Bill-to Address" = '' then begin
                    rec.Validate(Customer_PO, POHeaderRec.Customer_PO);
                    rec.Validate("Bill-to Customer No.", POHeaderRec.BillToCustomer);
                    rec.Validate("Bill-to Name", POHeaderRec.BillToName);
                    rec.Validate("Bill-to Address", POHeaderRec.BillToAddress);
                    rec.Validate("Bill-to Address 2", POHeaderRec.BillToAddress2);
                    rec.Validate("Bill-to City", POHeaderRec.BillToCity);
                    rec.Validate("Bill-to County", POHeaderRec.BillToState);
                    rec.Validate("Bill-to Post Code", POHeaderRec.BillToZipCode);
                    rec.Validate("Bill-to Country/Region Code", POHeaderRec.BillToCountry);
                    rec.Validate("Bill-to Contact", POHeaderRec.BillToContact);
                    rec.Modify;
                end;
                rec.Validate(Customer_PO, POHeaderRec.Customer_PO);
                rec.Validate(BOL_BillToCustomer, POHeaderRec.BillToCustomer);
                rec.Validate(BOL_BillToName, POHeaderRec.BillToName);
                rec.Validate(BOL_BillToAddress, POHeaderRec.BillToAddress);
                rec.Validate(BOL_BillToAddress2, POHeaderRec.BillToAddress2);
                rec.Validate(BOL_BillToCity, POHeaderRec.BillToCity);
                rec.Validate(BOL_BillToState, POHeaderRec.BillToState);
                rec.Validate(BOL_BillToZipCode, POHeaderRec.BillToZipCode);
                rec.Validate(BOL_BillToCountry, POHeaderRec.BillToCountry);
                rec.Validate(BOL_BillToContact, POHeaderRec.BillToContact);
                rec.Modify;
            end;
        end;
    end;
    trigger OnOpenPage()
    var
        SalesHeaderRec: Record "Sales Header";
        POHeaderRec: Record "Purchase Header";
        InterCompanyPartner: Record "IC Partner";
    begin
        InterCompanyPartner.SetFilter(Code, '=%1', 'DCC');
        if InterCompanyPartner.FindSet then begin
            InterCompanyPartner.Get(InterCompanyPartner.Code);
            POHeaderRec.ChangeCompany(InterCompanyPartner."Inbox Details");
            POHeaderRec.SetFilter("No.", '=%1', rec."External Document No.");
            if POHeaderRec.FindSet then begin
                if rec.Status <> rec.Status::Released then begin
                    if rec.Customer_PO = '' then begin
                        rec.Validate(Customer_PO, POHeaderRec.Customer_PO);
                    end;
                    if rec.BakeWeek = 0 then begin
                        rec.Validate(BakeWeek, POHeaderRec.BakeWeek);
                    end;
                    if rec."Bill-to Address" = '' then begin
                        rec.Validate("Bill-to Customer No.", POHeaderRec.BillToCustomer);
                        rec.Validate("Bill-to Name", POHeaderRec.BillToName);
                        rec.Validate("Bill-to Address", POHeaderRec.BillToAddress);
                        rec.Validate("Bill-to Address 2", POHeaderRec.BillToAddress2);
                        rec.Validate("Bill-to City", POHeaderRec.BillToCity);
                        rec.Validate("Bill-to County", POHeaderRec.BillToState);
                        rec.Validate("Bill-to Post Code", POHeaderRec.BillToZipCode);
                        rec.Validate("Bill-to Country/Region Code", POHeaderRec.BillToCountry);
                        rec.Validate("Bill-to Contact", POHeaderRec.BillToContact);
                    end;
                    rec.Validate(Customer_PO, POHeaderRec.Customer_PO);
                    rec.Validate(BOL_BillToCustomer, POHeaderRec.BillToCustomer);
                    rec.Validate(BOL_BillToName, POHeaderRec.BillToName);
                    rec.Validate(BOL_BillToAddress, POHeaderRec.BillToAddress);
                    rec.Validate(BOL_BillToAddress2, POHeaderRec.BillToAddress2);
                    rec.Validate(BOL_BillToCity, POHeaderRec.BillToCity);
                    rec.Validate(BOL_BillToState, POHeaderRec.BillToState);
                    rec.Validate(BOL_BillToZipCode, POHeaderRec.BillToZipCode);
                    rec.Validate(BOL_BillToCountry, POHeaderRec.BillToCountry);
                    rec.Validate(BOL_BillToContact, POHeaderRec.BillToContact);
                    rec.Modify;
                end;
            end;
        end;
    end;
}

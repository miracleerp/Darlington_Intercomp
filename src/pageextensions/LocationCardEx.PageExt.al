pageextension 50107 "LocationCardEx" extends "Location Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Use As In-Transit")
        {
            field(DropShipLocation; rec.DropShipLocation)
            {
                ApplicationArea = All;
            }
            field(Vendor; rec.Vendor)
            {
                ApplicationArea = All;
            }
        }
    }
    var
        myInt: Integer;
}

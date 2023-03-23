tableextension 50107 "LocationEx" extends Location
{
    fields
    {
        // Add changes to table fields here
        field(50107; DropShipLocation; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Use for Drop Ship';
        }
        field(50108; Vendor; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor No.';
            TableRelation = Vendor."No.";
        }
    }
    var myInt: Integer;
}

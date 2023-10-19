table 50121 "JCA Membership"
{
    Caption = 'Membership';
    DrillDownPageId = "JCA Memberships";
    LookupPageId = "JCA Memberships";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(3; "Membership Fee"; Decimal)
        {
            Caption = 'Membership Fee';
        }
    }

    keys
    {
        key(PK; Code)
        { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        { }
    }
}
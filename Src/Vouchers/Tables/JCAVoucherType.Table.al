table 50124 "JCA Voucher Type"
{
    Caption = 'Voucher Type';
    DrillDownPageId = "JCA Voucher Types";
    LookupPageId = "JCA Voucher Types";

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
        field(3; value; Decimal)
        {
            Caption = 'Value';
            DataClassification = SystemMetadata;
        }
        field(4; "Validation Period"; DateFormula)
        {
            Caption = 'Validation Period';
            DataClassification = SystemMetadata;
        }
        field(5; "Voucher Nos."; Code[20])
        {
            Caption = 'Voucher Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
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
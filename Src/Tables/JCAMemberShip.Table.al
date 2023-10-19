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
            DataClassification = SystemMetadata;
        }
        field(4; "Membership Period"; DateFormula)
        {
            Caption = 'Membership Period';
            DataClassification = SystemMetadata;
        }
        field(5; "Voucher Code"; Code[20])
        {
            caption = 'Voucher Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Voucher Type".Code;

            trigger OnValidate()
            var
                JCAVoucherType: Record "JCA Voucher Type";
            begin
                JCAVoucherType.Reset();
                if JCAVoucherType.get("Voucher Code") then
                    JCAVoucherType.testfield("Voucher Nos.");
                CalcFields("Voucher Description");
            end;
        }
        field(6; "Voucher Description"; Text[100])
        {
            Caption = 'Voucher Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Voucher Type".Description where(Code = field("Voucher Code")));
            Editable = false;
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
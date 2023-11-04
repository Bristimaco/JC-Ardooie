table 50129 "JCA Sponsor Formula"
{
    Caption = 'Sponsor Formula';
    DrillDownPageId = "JCA Sponsor Formulas";
    LookupPageId = "JCA Sponsor Formulas";

    fields
    {
        field(1; Code; code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(3; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = SystemMetadata;
        }
        field(4; "Voucher Code"; Code[20])
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
        field(5; "Voucher Description"; Text[100])
        {
            Caption = 'Voucher Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Voucher Type".Description where(Code = field("Voucher Code")));
            Editable = false;
        }
        field(6; Sponsors; Integer)
        {
            Caption = 'Sponsors';
            FieldClass = FlowField;
            CalcFormula = count(Customer where("JCA Sponsor" = const(true), "JCA Sponsor Formula" = field(code)));
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
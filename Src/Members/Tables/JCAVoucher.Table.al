table 50125 "JCA Voucher"
{
    Caption = 'Voucher';
    DrillDownPageId = "JCA Vouchers";
    LookupPageId = "JCA Vouchers";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; Type; Code[20])
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Voucher Type".Code;
            trigger OnValidate()
            var
                JCAVoucherType: Record "JCA Voucher Type";
            begin
                CalcFields(Description);
                JCAVoucherType.Reset();
                if JCAVoucherType.get(Type) then begin
                    validate("No. Series", JCAVoucherType."Voucher Nos.");
                    Validate(Value, JCAVoucherType.value);
                end;
            end;
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(4; "Valid Until"; Date)
        {
            Caption = 'Valid Until';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; "Issued To License ID"; Code[50])
        {
            Caption = 'Issued to License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID";

            trigger OnValidate()
            begin
                CalcFields("Issued To Name");
            end;
        }
        field(6; "Issued To Name"; Text[150])
        {
            Caption = 'Issued To Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Issued To License ID")));
            Editable = false;
        }
        field(7; "Used"; Boolean)
        {
            Caption = 'Used';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                validate("Used On", Today());
            end;
        }
        field(8; "Used On"; Date)
        {
            Caption = 'Used On';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            var
                VoucherIsNoLongerValidErr: label 'This voucher is no longer valid!';
            begin
                if "Used On" > "Valid Until" then
                    error(VoucherIsNoLongerValidErr);
            end;
        }
        field(9; "Description"; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Voucher Type".Description where(Code = field(Type)));
            Editable = false;
        }
        field(10; Value; Decimal)
        {
            Caption = 'Value';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(11; "Issued On"; Date)
        {
            Caption = 'Issued On';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; Code)
        { }
    }

    trigger OnInsert()
    var
        NoSeriesManagement: codeunit NoSeriesManagement;
    begin
        TestField(Type);
        TestField("No. Series");

        clear(NoSeriesManagement);
        validate(Code, NoSeriesManagement.GetNextNo("No. Series", Today(), true));

        validate("Issued On", today());
    end;
}
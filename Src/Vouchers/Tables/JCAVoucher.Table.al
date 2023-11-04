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
        field(5; "Issued To Type"; enum "JCA Voucher Issued To Type")
        {
            Caption = 'Issued To Type';
            DataClassification = SystemMetadata;
        }
        field(6; "Issued To No."; Code[50])
        {
            Caption = 'Issued to No.';
            DataClassification = SystemMetadata;
            TableRelation = if ("Issued To Type" = const(Member)) "JCA Member"."License ID" else
            if ("Issued To Type" = const(Sponsor)) customer."No.";

            trigger OnValidate()
            var
                Customer: Record Customer;
                JCAMember: record "JCA Member";
            begin
                case "Issued To Type" of
                    "Issued To Type"::Sponsor:
                        begin
                            customer.reset();
                            if Customer.get("Issued To No.") then
                                Validate("Issued To Name", customer.Name);
                        end;
                    "Issued To Type"::Member:
                        begin
                            JCAMember.reset();
                            if JCAMember.get("Issued To No.") then
                                Validate("Issued To Name", JCAMember."Full Name");
                        end;
                end;
            end;
        }
        field(7; "Issued To Name"; Text[150])
        {
            Caption = 'Issued To Name';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(8; "Used"; Boolean)
        {
            Caption = 'Used';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                validate("Used On", Today());
            end;
        }
        field(9; "Used On"; Date)
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
        field(10; "Description"; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Voucher Type".Description where(Code = field(Type)));
            Editable = false;
        }
        field(11; Value; Decimal)
        {
            Caption = 'Value';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(12; "Issued On"; Date)
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
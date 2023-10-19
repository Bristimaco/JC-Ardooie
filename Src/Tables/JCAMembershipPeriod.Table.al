table 50122 "JCA Membership Period"
{
    Caption = 'Membership Period';
    DrillDownPageId = "JCA Membership Periods";
    LookupPageId = "JCA Membership Periods";

    fields
    {
        field(1; "Member License ID"; Code[20])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID";

            trigger OnValidate()
            begin
                CalcFields("Member Full Name");
            end;
        }
        field(2; "Member Full Name"; Text[150])
        {
            Caption = 'Member Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(3; "Membership Code"; Code[20])
        {
            Caption = 'Membership Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Membership".Code;

            trigger OnValidate()
            var
                JCAMembership: record "JCA Membership";
            begin
                CalcFields("Membership Description");
                JCAMembership.Reset();
                if JCAMembership.get("Membership Code") then
                    Validate("Membership Fee", JCAMembership."Membership Fee")
                else
                    validate("Membership Fee", 0);
            end;
        }
        field(4; "Membership Description"; text[100])
        {
            Caption = 'Membership Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Membership".Description where(Code = field("Membership Code")));
            Editable = false;
        }
        field(5; "Membership Fee"; Decimal)
        {
            Caption = 'Membership Fee';
            DataClassification = SystemMetadata;
        }
        field(6; "Payment Requested On"; DateTime)
        {
            Caption = 'Payment Requested On';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(7; "Membership Payed"; Boolean)
        {
            Caption = 'Membership Payed';
            DataClassification = SystemMetadata;

        }
        field(8; "Membership Starting Date"; Date)
        {
            Caption = 'Membership Starting Date';
            DataClassification = SystemMetadata;
        }
        field(9; "Membership Ending Date"; Date)
        {
            Caption = 'Membership Ending Date';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Member License ID", "Membership Code", "Membership Starting Date", "Membership Ending Date")
        { }
        key(StartingDate; "Membership Starting Date")
        { }
    }
}
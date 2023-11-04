table 50130 "JCA Sponsorship Period"
{
    Caption = 'Sponsorshio Period';
    DrillDownPageId = "JCA Sponsorship Periods";
    LookupPageId = "JCA Sponsorship Periods";

    fields
    {
        field(1; "Sponsor No."; Code[50])
        {
            Caption = 'Sponsor No.';
            DataClassification = SystemMetadata;
            TableRelation = Customer."No." where("JCA Sponsor" = const(true));

            trigger OnValidate()
            begin
                CalcFields("Sponsor Name");
            end;
        }
        field(2; "Sponsor Name"; Text[150])
        {
            Caption = 'Sponsor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Sponsor No.")));
            Editable = false;
        }
        field(3; "Sponsorship Code"; Code[20])
        {
            Caption = 'Sponsorship Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Sponsor Formula".Code;

            trigger OnValidate()
            var
                JCASponsorFormula: record "JCA Sponsor Formula";
            begin
                CalcFields("Sponsorship Description");
                JCASponsorFormula.Reset();
                JCASponsorFormula.get("Sponsorship Code");
                JCASponsorFormula.testfield("Unit Price");
                JCASponsorFormula.TestField("Sponsorship Period");
                Validate("Sponsorship Fee", JCASponsorFormula."Unit Price");
            end;
        }
        field(4; "Sponsorship Description"; text[100])
        {
            Caption = 'Sponsorship Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Sponsor Formula".Description where(Code = field("Sponsorship Code")));
            Editable = false;
        }
        field(5; "Sponsorship Fee"; Decimal)
        {
            Caption = 'Sponsorship Fee';
            DataClassification = SystemMetadata;
        }
        field(6; "Payment Requested On"; DateTime)
        {
            Caption = 'Payment Requested On';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(7; "Sponsorship Payed"; Boolean)
        {
            Caption = 'Membership Payed';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            var
                Customer: Record "Customer";
                JCASponsorFormula: record "JCA Sponsor Formula";
            begin
                if "Sponsorship Payed" then begin
                    JCASponsorFormula.Reset();
                    JCASponsorFormula.get("Sponsorship Code");
                    if JCASponsorFormula."Voucher Code" <> '' then begin
                        Customer.Reset();
                        Customer.get("Sponsor No.");
                        Customer.IssueVoucher(JCASponsorFormula."Voucher Code");
                    end;
                end;
            end;
        }
        field(8; "Sponsorship Starting Date"; Date)
        {
            Caption = 'Sponsorship Starting Date';
            DataClassification = SystemMetadata;
        }
        field(9; "Sponsorship Ending Date"; Date)
        {
            Caption = 'Sponsorship Ending Date';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Sponsor No.", "Sponsorship Code", "Sponsorship Starting Date", "Sponsorship Ending Date")
        { }
        key(StartingDate; "Sponsorship Starting Date")
        { }
    }

    procedure CalculateEndDate()
    var
        JCASPonsorFormula: record "JCA Sponsor Formula";
    begin
        TestField("Sponsorship Code");
        TestField("Sponsorship Starting Date");
        JCASPonsorFormula.Reset();
        JCASPonsorFormula.get("Sponsorship Code");
        JCASPonsorFormula.testfield("Sponsorship Period");
        Rec.validate("Sponsorship Ending Date", CalcDate(JCASPonsorFormula."Sponsorship Period", Rec."Sponsorship Starting Date"));
    end;
}
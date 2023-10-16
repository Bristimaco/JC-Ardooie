table 50108 "JCA Tr. Session Participant"
{
    Caption = 'Training Session Participant';

    fields
    {
        field(1; "Training Session No."; Code[20])
        {
            Caption = 'Training Session No.';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Training Session"."No.";

            trigger OnValidate()
            var
                JCATrainingSession: record "JCA Training Session";
            begin
                JCATrainingSession.Reset();
                if JCATrainingSession.get(JCATrainingSession."No.") then
                    Validate("Training Group Code", JCATrainingSession."Training Group Code");
            end;
        }
        field(2; "Club Member"; Boolean)
        {
            Caption = 'Club Member';
            DataClassification = SystemMetadata;
        }
        field(3; "Member License ID"; Code[20])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = if ("Club Member" = const(true)) "JCA Training Group Member"."Member License ID" where("Training Group Code" = field("Training Group Code"));

            trigger OnValidate()
            begin
                CalcFields("Member Full Name");
            end;
        }
        field(4; "Training Group Code"; Code[20])
        {
            Caption = 'Training Group Code';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Training Session"."Training Group Code" where("No." = field("Training Session No.")));
            Editable = false;
        }
        field(5; "Member Full Name"; Text[150])
        {
            Caption = 'Member Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(6; Participation; Boolean)
        {
            Caption = 'Participation';
            DataClassification = SystemMetadata;
        }
        field(7; "Club No."; code[20])
        {
            Caption = 'Club No.';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Club"."No.";

            trigger OnValidate()
            begin
                CalcFields("Club Name");
            end;
        }
        field(8; "Club Name"; Text[100])
        {
            Caption = 'Club Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Club".Name where("No." = field("Club No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Training Session No.", "Member License ID")
        { }
    }
}
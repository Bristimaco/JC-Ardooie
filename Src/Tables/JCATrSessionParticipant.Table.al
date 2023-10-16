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
        field(2; "Member License ID"; Code[20])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Training Group Member"."Member License ID" where("Training Group Code" = field("Training Group Code"));

            trigger OnValidate()
            begin
                CalcFields("Member Full Name");
            end;
        }
        field(3; "Training Group Code"; Code[20])
        {
            Caption = 'Training Group Code';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Training Session"."Training Group Code" where("No." = field("Training Session No.")));
            Editable = false;
        }
        field(4; "Member Full Name"; Text[150])
        {
            Caption = 'Member Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(5; Participation; Boolean)
        {
            Caption = 'Participation';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Training Session No.", "Member License ID")
        { }
    }
}
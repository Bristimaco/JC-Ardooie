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
            TableRelation = if ("Club Member" = const(true)) "JCA Training Group Member"."Member License ID" where("Training Group Code" = field("Training Group Code")) else
            if ("Club Member" = const(false)) "JCA Guest Member Tr. Group"."Guest Member License ID" where("Training Group Code" = field("Training Group Code"));

            trigger OnValidate()
            var
                JCAGuestMember: record "JCA Guest Member";
                JCAMember: record "JCA Member";
                JCAClub: record "JCA Club";
            begin
                if "Club Member" then begin
                    JCAClub.Reset();
                    JCAClub.setrange("Our Club", true);
                    JCAClub.findfirst();

                    JCAMember.reset();
                    if JCAMember.get("Member License ID") then begin
                        validate("Member Full Name", JCAMember."Full Name");
                        validate("Club No.", JCAClub."No.");
                        validate(Belt, JCAMember.Belt);
                    end;
                end else begin
                    JCAGuestMember.reset();
                    if JCAGuestMember.get("Member License ID") then begin
                        validate("Member Full Name", JCAGuestMember."Full Name");
                        validate("Club No.", JCAGuestMember."Club No.");
                        Validate(Belt, JCAGuestMember.Belt);
                    end;
                end;
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
            DataClassification = SystemMetadata;
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
        field(9; Belt; Enum "JCA Belt")
        {
            Caption = 'Belt';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Training Session No.", "Member License ID")
        { }
    }

    procedure ProcessTrainingAttendeeScan(AttendeeLicenseID: code[20])
    var
        JCATrainingManagement: Codeunit "JCA Training Management";
    begin
        Clear(JCATrainingManagement);
        JCATrainingManagement.ProcessTrainingAttendeeScan(Rec."Training Session No.", AttendeeLicenseID);
    end;
}
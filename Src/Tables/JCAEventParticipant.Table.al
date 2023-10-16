table 50112 "JCA Event Participant"
{
    Caption = 'Event Participant';

    fields
    {
        field(1; "Event No."; Code[20])
        {
            Caption = 'Event No.';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Event"."No.";

            trigger OnValidate()
            var
                JCAEvent: record "JCA Event";
            begin
                JCAEvent.Reset();
                if JCAEvent.get("Event No.") then begin
                    validate("Country Code", JCAEvent."Country Code");
                end;
            end;
        }
        field(2; "Member License ID"; Code[20])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID";

            trigger OnValidate()
            var
                JCAMember: record "JCA Member";
            begin
                JCAMember.Reset();
                if JCAMember.Get("Member License ID") then begin
                    Validate(Gender, JCAMember.Gender);
                end;
                calcfields("Member Full Name");
            end;
        }
        field(3; "Country Code"; Code[20])
        {
            Caption = 'Country Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region".Code;
        }
        field(4; Gender; Enum "JCA Gender")
        {
            Caption = 'Gender';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; "Member Full Name"; Text[150])
        {
            Caption = 'Member Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(6; Invited; Boolean)
        {
            Caption = 'Invited';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(7; "Applied for Registration"; Boolean)
        {
            Caption = 'Applied for Registration';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                testfield(Invited);
            end;
        }
        field(8; Registered; Boolean)
        {
            Caption = 'Registered';
            DataClassification = SystemMetadata;
            Editable = false;

            trigger OnValidate()
            begin
                testfield("Applied for Registration");
            end;
        }
        field(9; "Age Group Code"; Code[10])
        {
            Caption = 'Age Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Age Group".Code where("Country Code" = field("Country Code"), Gender = field(Gender));

            trigger OnValidate()
            begin
                CalcFields("Age Group Description");
            end;

        }
        field(10; "Age Group Description"; text[50])
        {
            Caption = 'Age Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Age Group".Description where("Country Code" = field("Country Code"), Gender = field(Gender), Code = field("Age Group Code")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Event No.", "Member License ID")
        { }
    }

    procedure SendInvitationMail()
    var
        JCAEvent: Record "JCA Event";
        JCAMailManagement: codeunit "JCA Mail Management";
        InvitationSentLbl: Label 'Invitation has been sent';
    begin
        JCAEvent.Reset();
        JCAEvent.Get(Rec."Event No.");
        clear(JCAMailManagement);
        if JCAMailManagement.SendEventInvitationMail(Rec."Member License ID", JCAEvent) then begin
            Rec.Validate(Invited, true);
            rec.Modify(true);
            Message(InvitationSentLbl);
        end;
    end;
}
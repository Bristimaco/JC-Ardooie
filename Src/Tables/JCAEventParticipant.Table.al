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
                if not "Applied for Registration" then
                    testfield(Registered, false);
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
                if xRec.Registered <> rec.Registered then
                    if rec.Registered then
                        SendRegistrationConfirmationMail()
                    else
                        SendUnRegistrationConfirmationMail();
            end;
        }
        field(9; "Registration Confirmed"; Boolean)
        {
            Caption = 'Registration Confirmed';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(10; "Age Group Code"; Code[10])
        {
            Caption = 'Age Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Age Group".Code where("Country Code" = field("Country Code"), Gender = field(Gender));

            trigger OnValidate()
            begin
                CalcFields("Age Group Description");
            end;

        }
        field(11; "Age Group Description"; text[50])
        {
            Caption = 'Age Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Age Group".Description where("Country Code" = field("Country Code"), Gender = field(Gender), Code = field("Age Group Code")));
            Editable = false;
        }
        field(12; "No-Show"; Boolean)
        {
            Caption = 'No-Show';
            DataClassification = SystemMetadata;
        }
        field(13; Result; enum "JCA Event Result")
        {
            Caption = 'Result';
            DataClassification = SystemMetadata;
        }
        field(14; "Result Mails Sent"; Boolean)
        {
            Caption = 'Result Mails Sent';
            DataClassification = SystemMetadata;
        }
        field(15; "Supervisor Comment"; text[250])
        {
            Caption = 'Supervisor Comment';
            DataClassification = SystemMetadata;
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

    procedure SendRegistrationConfirmationMail()
    var
        JCAEvent: record "JCA Event";
        JCAMailManagement: codeunit "JCA Mail Management";
    begin
        JCAEvent.Reset();
        JCAEvent.get(rec."Event No.");
        clear(JCAMailManagement);
        if JCAMailManagement.SendRegistrationConfirmationMail(rec."Member License ID", JCAEvent) then begin
            rec.validate("Registration Confirmed", true);
            rec.Modify(true);
        end;
    end;

    procedure SendUnRegistrationConfirmationMail()
    var
        JCAEvent: record "JCA Event";
        JCAMailManagement: codeunit "JCA Mail Management";
    begin
        JCAEvent.Reset();
        JCAEvent.get(rec."Event No.");
        clear(JCAMailManagement);
        if JCAMailManagement.SendUnRegistrationConfirmationMail(rec."Member License ID", JCAEvent) then begin
            rec.validate("Registration Confirmed", false);
            rec.Modify(true);
        end;
    end;

    procedure ConfirmRegistration()
    begin
        TestField(Registered, false);
        validate(Registered, true);
    end;

    procedure ConfirmUnRegistration()
    begin
        TestField(Registered, true);
        validate(Registered, false);
    end;

    procedure SendEventResultMail()
    var
        JCAEvent: record "JCA Event";
        JCAMailManagement: Codeunit "JCA Mail Management";
    begin
        JCAEvent.Reset();
        JCAEvent.get(Rec."Event No.");
        if not JCAEvent."Send Result Mails" then
            exit;

        clear(JCAMailManagement);
        JCAMailManagement.SendEventResultMail(Rec);
        Validate("Result Mails Sent", true);
        Modify(true);
    end;
}
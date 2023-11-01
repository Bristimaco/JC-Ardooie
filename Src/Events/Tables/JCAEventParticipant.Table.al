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
                if JCAEvent.get("Event No.") then
                    validate("Country Code", JCAEvent."Country Code");
            end;
        }
        field(2; "Member License ID"; Code[50])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            //TableRelation = "JCA Member"."License ID";
            TableRelation = "JCA Member"."License ID" where("Active Membership" = field("Membership Filter"), "Membersh. Start Date Filter" = field("Membersh. Start Date Filter"), "Membersh. End Date Filter" = field("Membersh. End Date Filter"), "Member Type" = filter(Judoka | Both));

            trigger OnValidate()
            var
                JCAMember: record "JCA Member";
            begin
                JCAMember.Reset();
                if JCAMember.Get("Member License ID") then
                    Validate(Gender, JCAMember.Gender);
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
        field(16; "Membersh. Start Date Filter"; Date)
        {
            Caption = 'Membership Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(17; "Membersh. End Date Filter"; Date)
        {
            Caption = 'Membership End Date Filter';
            FieldClass = FlowFilter;
        }
        field(18; "Membership Filter"; Code[20])
        {
            Caption = 'Membership Filter';
            FieldClass = FlowFilter;
        }
        field(19; "Weight Group Code"; Code[20])
        {
            Caption = 'Weight Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Weight Group".Code where(Gender = field(Gender), "Age Group" = field("Age Group Code"));
        }
        field(20; "Refund Payed"; Boolean)
        {
            Caption = 'Refund Payed';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                testfield("No-Show", true);
            end;
        }
    }

    keys
    {
        key(PK; "Event No.", "Member License ID")
        { }
    }

    procedure SendInvitationMail()
    var
        tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary;
        JCAEventMailing: Interface JCAEventMailing;
        InvitationSentLbl: Label 'Invitation has been sent';
    begin
        JCAEventMailing := enum::"JCA Mail Message Type"::Invitation;

        tempJCAMailMessageTemplate.Reset();
        tempJCAMailMessageTemplate.init();
        tempJCAMailMessageTemplate."Mail Message Type" := enum::"JCA Mail Message Type"::Invitation;
        tempJCAMailMessageTemplate."Member License ID" := Rec."Member License ID";
        tempJCAMailMessageTemplate."Event No." := Rec."Event No.";

        if JCAEventMailing.SendMail(tempJCAMailMessageTemplate) then begin
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
        TestField("Weight Group Code");
        JCAEvent.Reset();
        JCAEvent.get(rec."Event No.");
        clear(JCAMailManagement);
        if JCAMailManagement.SendRegistrationConfirmationMail(rec, JCAEvent) then begin
            rec.validate("Registration Confirmed", true);
            rec.Modify(true);
        end;
    end;

    procedure SendUnRegistrationConfirmationMail()
    var
        JCAEvent: record "JCA Event";
        JCAMailManagement: codeunit "JCA Mail Management";
    begin
        TestField("Weight Group Code");
        JCAEvent.Reset();
        JCAEvent.get(rec."Event No.");
        clear(JCAMailManagement);
        if JCAMailManagement.SendUnRegistrationConfirmationMail(rec, JCAEvent) then begin
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
        tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary;
        JCAEventMailing: Interface JCAEventMailing;
    begin
        JCAEvent.Reset();
        JCAEvent.get(Rec."Event No.");
        if not JCAEvent."Send Result Mails" then
            exit;

        tempJCAMailMessageTemplate.Reset();
        tempJCAMailMessageTemplate.init();
        tempJCAMailMessageTemplate."Mail Message Type" := enum::"JCA Mail Message Type"::"Event Result";
        tempJCAMailMessageTemplate."Member License ID" := Rec."Member License ID";
        tempJCAMailMessageTemplate."Event No." := Rec."Event No.";
        tempJCAMailMessageTemplate."Event Result" := rec.Result;

        JCAEventMailing := enum::"JCA Mail Message Type"::"Event Result";
        JCAEventMailing.SendMail(tempJCAMailMessageTemplate);
        Validate("Result Mails Sent", true);
        Modify(true);
    end;
}
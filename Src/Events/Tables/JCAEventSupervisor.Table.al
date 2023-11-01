table 50113 "JCA Event Supervisor"
{
    Caption = 'Event Supervisor';

    fields
    {
        field(1; "Event No."; Code[20])
        {
            Caption = 'Event No.';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Event"."No.";
        }
        field(2; "Member License ID"; Code[50])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID" where("Active Membership" = field("Membership Filter"), "Membersh. Start Date Filter" = field("Membersh. Start Date Filter"), "Membersh. End Date Filter" = field("Membersh. End Date Filter"), "Member Type" = filter(Trainer | Both));

            trigger OnValidate()
            begin
                calcfields("Member Full Name");
            end;
        }
        field(3; "Member Full Name"; Text[150])
        {
            Caption = 'Member Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(4; Invited; Boolean)
        {
            Caption = 'Invited';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; "Applied for Registration"; Boolean)
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
        field(10; "Membersh. Start Date Filter"; Date)
        {
            Caption = 'Membership Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(11; "Membersh. End Date Filter"; Date)
        {
            Caption = 'Membership End Date Filter';
            FieldClass = FlowFilter;
        }
        field(12; "Membership Filter"; Code[20])
        {
            Caption = 'Membership Filter';
            FieldClass = FlowFilter;
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
        tempJCAMailMessageTemplate.Reset();
        tempJCAMailMessageTemplate.init();
        tempJCAMailMessageTemplate."Mail Message Type" := enum::"JCA Mail Message Type"::Invitation;
        tempJCAMailMessageTemplate."Event No." := rec."Event No.";
        tempJCAMailMessageTemplate."Member License ID" := rec."Member License ID";

        JCAEventMailing := Enum::"JCA Mail Message Type"::Invitation;
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
}
table 50110 "JCA Event"
{
    Caption = 'Event';
    DrillDownPageId = "JCA Events";
    LookupPageId = "JCA Events";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(3; Type; enum "JCA Event Type")
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }
        field(5; "Registration Deadline"; Date)
        {
            Caption = 'Registration Deadline';
            DataClassification = SystemMetadata;
        }
        field(6; Status; Enum "JCA Event Status")
        {
            Caption = 'Status';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                CheckParticipantsAndSupervisorStatus();
            end;
        }
        field(7; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region".Code;
        }
        field(8; "Age Groups"; Integer)
        {
            Caption = 'Age Groups';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event Age Group" where("Event No." = field("No.")));
            Editable = false;
        }
        field(9; "Potential Participants"; Integer)
        {
            Caption = 'Potential Participants';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event Participant" where("Event No." = field("No.")));
            Editable = false;
        }
        field(10; "Invited Participants"; Integer)
        {
            Caption = 'Invited Participants';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event Participant" where("Event No." = field("No."), Invited = const(true)));
            Editable = false;
        }
        field(11; "Registered Participants"; Integer)
        {
            Caption = 'Registered Participants';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event Participant" where("Event No." = field("No."), Registered = const(true)));
            Editable = false;
        }
        Field(12; "Send Result Mails"; Boolean)
        {
            Caption = 'Send Result Mails';
            DataClassification = SystemMetadata;
            InitValue = true;
        }
        field(13; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = SystemMetadata;
        }
        field(14; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = SystemMetadata;
            TableRelation = "Post Code".Code where("Country/Region Code" = field("Country Code"));

            trigger OnValidate()
            var
                PostCode: record "Post Code";
                PostCodes: page "Post Codes";
            begin
                PostCode.Reset();
                PostCode.setrange(Code, "Post Code");
                PostCode.setrange("Country/Region Code", "Country Code");
                if PostCode.count() > 1 then begin
                    Clear(PostCodes);
                    PostCodes.SetTableView(PostCode);
                    PostCodes.LookupMode := true;
                    if PostCodes.RunModal() = Action::LookupOK then begin
                        PostCodes.GetRecord(PostCode);
                        City := PostCode.City;
                    end;
                end else begin
                    if PostCode.findfirst() then
                        City := PostCode.City;
                end;

            end;
        }
        field(15; City; Text[100])
        {
            Caption = 'City';
            DataClassification = SystemMetadata;
            TableRelation = "Post Code".City where(Code = field("Post Code"), "Country/Region Code" = field("Country Code"));
        }
        field(16; "Send Invitation Reminders"; Boolean)
        {
            Caption = 'Send Invitaton Reminders';
            DataClassification = SystemMetadata;
        }
        field(17; "Last Reminder Mail Sent On"; Date)
        {
            Caption = 'Last Reminder Mail Sent On';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "No.")
        { }
    }

    trigger OnInsert()
    var
        JCASetup: Record "JCA Setup";
        NoSeriesManagement: codeunit NoSeriesManagement;
    begin
        JCASetup.Reset();
        JCASetup.get();
        JCASetup.testfield("Event Nos.");
        Validate("No.", NoSeriesManagement.GetNextNo(JCASetup."Event Nos.", Today(), true));
    end;

    trigger OnDelete()
    var
        JCAEventAgeGroup: record "JCA Event Age Group";
        JCAEventSupervisor: record "JCA Event Supervisor";
        JCAEventParticipant: record "JCA Event Participant";
    begin
        JCAEventAgeGroup.Reset();
        JCAEventAgeGroup.setrange("Event No.", "No.");
        JCAEventAgeGroup.deleteall(true);

        JCAEventSupervisor.Reset();
        JCAEventSupervisor.setrange("Event No.", "No.");
        JCAEventSupervisor.deleteall(true);

        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Event No.", "No.");
        JCAEventParticipant.DeleteAll(true);
    end;

    procedure OpenCard()
    var
        JCAEvent: record "JCA Event";
        JCAEventCard: page "JCA Event Card";
    begin
        JCAEvent.Reset();
        JCAEvent.setrange("No.", "No.");
        JCAEvent.findfirst();
        clear(JCAEventCard);
        JCAEventCard.SetRecord(JCAEvent);
        JCAEventCard.Run();
    end;

    procedure OpenSupervisorSheet()
    var
        JCAEventParticipant: record "JCA Event Participant";
        JCAEventSupervisorSheet: page "JCA Event Supervisor Sheet";
        SetToInProgressQst: Label 'Do you want to set the Event to status In Progress?';
    begin
        if not (rec.status in [rec.status::"Registrations Processed", rec.status::"In Progress"]) then
            exit;

        if Rec.Status <> rec.Status::"In Progress" then
            if not Confirm(SetToInProgressQst) then
                exit;
        if rec.Status <> rec.status::"In Progress" then begin
            rec.Validate(Status, rec.status::"In Progress");
            rec.modify(true);
        end;

        Rec.TestField(status, rec.status::"In Progress");

        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Event No.", "No.");
        clear(JCAEventSupervisorSheet);
        JCAEventSupervisorSheet.SetTableView(JCAEventParticipant);
        JCAEventSupervisorSheet.run();
    end;

    procedure FetchParticipants()
    var
        JCAEventManagement: Codeunit "JCA Event Management";
    begin
        clear(JCAEventManagement);
        JCAEventManagement.FetchEventParticipants(Rec);
    end;

    procedure SendInvitations()
    var
        JCAEventManagement: codeunit "JCA Event Management";
    begin
        clear(JCAEventManagement);
        JCAEventManagement.SendEventInvitations(Rec);
        Rec.validate(Status, status::"Invitations Sent");
        Rec.modify(true);
    end;

    procedure SendInvitationReminders()
    var
        JCAEventManagement: Codeunit "JCA Event Management";
    begin
        if not Rec."Send Invitation Reminders" then
            exit;

        Clear(JCAEventManagement);
        JCAEventManagement.SendEventInvitationReminders(Rec);
        rec.Validate("Last Reminder Mail Sent On", Today());
        rec.Modify(true);
    end;

    local procedure CheckParticipantsAndSupervisorStatus()
    var
        JCAEvenManagement: Codeunit "JCA Event Management";
    begin
        Clear(JCAEvenManagement);
        JCAEvenManagement.CheckParticipantsAndSupervistors(Rec);
    end;

    procedure GetParticipants(var JCAEventParticipant: record "JCA Event Participant"): Boolean
    begin
        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Event No.", Rec."No.");
        exit(JCAEventParticipant.findset());
    end;

    procedure GetSupervisors(var JCAEventSupervisor: record "JCA Event Supervisor"): Boolean
    begin
        JCAEventSupervisor.Reset();
        JCAEventSupervisor.setrange("Event No.", Rec."No.");
        exit(JCAEventSupervisor.findset());
    end;
}
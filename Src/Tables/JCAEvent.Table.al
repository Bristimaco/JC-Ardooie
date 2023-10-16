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
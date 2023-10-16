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
}
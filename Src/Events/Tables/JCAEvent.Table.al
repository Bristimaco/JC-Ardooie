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
                MailGroupedEventResults();
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
                end else
                    if PostCode.findfirst() then
                        City := PostCode.City;
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
        field(18; "Fee Payment"; enum "JCA Fee Payment")
        {
            Caption = 'Fee Payment';
            DataClassification = SystemMetadata;
        }
        field(19; "Fee Payed To No."; Code[20])
        {
            Caption = 'Fee Payed To No.';
            DataClassification = SystemMetadata;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                CalcFields("Fee Payed To Name");
            end;
        }
        field(20; "Fee Payed To Name"; Text[100])
        {
            Caption = 'Fee Payed to Name';
            FieldClass = FlowField;
            CalcFormula = lookup(vendor.Name where("No." = field("Fee Payed To No.")));
            Editable = false;
        }
        field(21; "Registration Fee"; Decimal)
        {
            Caption = 'Registration Fee';
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
        JCAEventManagement.SendEventInvitations(Rec."No.");
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
        JCAEventManagement.SendEventInvitationReminders(Rec."No.");
        rec.Validate("Last Reminder Mail Sent On", Today());
        rec.Modify(true);
    end;

    local procedure CheckParticipantsAndSupervisorStatus()
    var
        JCAEventManagement: Codeunit "JCA Event Management";
    begin
        Clear(JCAEventManagement);
        JCAEventManagement.CheckParticipantsAndSupervistors(Rec);
    end;

    local procedure MailGroupedEventResults()
    var
        JCAEventManagement: codeunit "JCA Event Management";
    begin
        clear(JCAEventManagement);
        JCAEventManagement.MailGroupedEventResults(Rec);
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

    procedure ReturnAgeGroupsText(): Text
    var
        JCAEventAgeGroup: record "JCA Event Age Group";
        AgeGroups: list of [Text];
        AgeGroup: text;
        FirstAgeGroup: Boolean;
        ReturnValue: Text;
    begin
        ReturnValue := '';
        clear(AgeGroups);
        JCAEventAgeGroup.Reset();
        JCAEventAgeGroup.setrange("Event No.", rec."No.");
        if JCAEventAgeGroup.findset() then
            repeat
                if not AgeGroups.Contains(JCAEventAgeGroup."Age Group Code") then
                    AgeGroups.Add(JCAEventAgeGroup."Age Group Code");
            until JCAEventAgeGroup.Next() = 0;
        if AgeGroups.Count() > 0 then begin
            ReturnValue := '(';
            FirstAgeGroup := true;
            foreach AgeGroup in agegroups do begin
                if not FirstAgeGroup then
                    ReturnValue += ',';
                if AgeGroup <> '' then begin
                    ReturnValue += AgeGroup;
                    FirstAgeGroup := false;
                end;
            end;
            ReturnValue := ReturnValue + ')';
            exit(ReturnValue);
        end;
    end;
}
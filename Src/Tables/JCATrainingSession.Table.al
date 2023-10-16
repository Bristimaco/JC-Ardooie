table 50105 "JCA Training Session"
{
    Caption = 'Training Session';
    DrillDownPageId = "JCA Training Sessions";
    LookupPageId = "JCA Training Sessions";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }
        field(3; "Training Group Code"; Code[20])
        {
            Caption = 'Training Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Training Group".Code;

            trigger OnValidate()
            var
                JCATrainingGroup: record "JCA Training Group";
            begin
                CalcFields("Training Group Description");
                JCATrainingGroup.reset();
                if JCATrainingGroup.get("Training Group Code") then
                    validate("Open for Other Clubs", JCATrainingGroup."Open for Other Clubs");
            end;
        }
        field(4; "Training Group Description"; Text[50])
        {
            Caption = 'Training Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Training Group".Description where(Code = field("Training Group Code")));
            Editable = false;
        }
        field(5; Status; enum "JCA Training Session Status")
        {
            Caption = 'Status';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(6; "Potential Participants"; Integer)
        {
            Caption = 'Potential Participants';
            FieldClass = FlowField;
            CalcFormula = count("JCA Tr. Session Participant" where("Training Session No." = field("No.")));
            Editable = false;
        }
        field(7; "Actual Participants"; Integer)
        {
            Caption = 'Actual Participants';
            FieldClass = FlowField;
            CalcFormula = count("JCA Tr. Session Participant" where("Training Session No." = field("No."), Participation = const(true)));
            Editable = false;
        }
        field(8; "Open for Other Clubs"; Boolean)
        {
            Caption = 'Open for Other Clubs';
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
        JCASetup.testfield("Training Session Nos.");
        Validate("No.", NoSeriesManagement.GetNextNo(JCASetup."Training Session Nos.", Today(), true));
    end;

    trigger OnDelete()
    var
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
    begin
        JCATrSessionParticipant.Reset();
        JCATrSessionParticipant.setrange("Training Session No.", "No.");
        JCATrSessionParticipant.deleteall(true);
    end;

    procedure OpenCard()
    var
        JCATrainingSession: record "JCA Training Session";
        JCATrainingSessionCard: page "JCA Training Session Card";
    begin
        JCATrainingSession.Reset();
        JCATrainingSession.setrange("No.", "No.");
        JCATrainingSession.findfirst();
        clear(JCATrainingSessionCard);
        JCATrainingSessionCard.SetRecord(JCATrainingSession);
        JCATrainingSessionCard.Run();
    end;

    procedure CloseTrainingSession()
    var
        JCATrainingManagement: codeunit "JCA Training Management";
    begin
        Clear(JCATrainingManagement);
        JCATrainingManagement.CloseTrainingSession(Rec);
    end;

    procedure FetchParticipants()
    var
        JCATrainingManagement: codeunit "JCA Training Management";
    begin
        clear(JCATrainingManagement);
        JCATrainingManagement.FectchTrainingSessionParticipants(Rec);
        if "Open for Other Clubs" then
            JCATrainingManagement.FetchTrainingSessionParticipantsFromOtherClubs(Rec);
    end;
}
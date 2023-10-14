table 50105 "JCA Training Session"
{
    Caption = 'Training Session';
    DrillDownPageId = "JCA Training Sessions";
    LookupPageId = "JCA Training Sessions";

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
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
            begin
                CalcFields("Training Group Description");
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
            CalcFormula = count("JCA Tr. Session Participant" where("Training Session ID" = field(ID)));
            Editable = false;
        }
        field(7; "Actual Participants"; Integer)
        {
            Caption = 'Actual Participants';
            FieldClass = FlowField;
            CalcFormula = count("JCA Tr. Session Participant" where("Training Session ID" = field(ID), Participation = const(true)));
            Editable = false;
        }
    }

    keys
    {
        key(PK; ID)
        { }
    }

    trigger OnDelete()
    var
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
    begin
        JCATrSessionParticipant.Reset();
        JCATrSessionParticipant.setrange("Training Session ID", ID);
        JCATrSessionParticipant.deleteall(true);
    end;

    procedure OpenCard()
    var
        JCATrainingSession: record "JCA Training Session";
        JCATrainingSessionCard: page "JCA Training Session Card";
    begin
        JCATrainingSession.Reset();
        JCATrainingSession.setrange(ID, ID);
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
    end;
}
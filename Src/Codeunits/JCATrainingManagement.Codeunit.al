codeunit 50101 "JCA Training Management"
{
    procedure CreateNewTrainingSession(OpenTrainingSessionCard: Boolean)
    var
        JCATrainingSession: Record "JCA Training Session";
    begin
        JCATrainingSession.Reset();
        JCATrainingSession.ID := 0;
        JCATrainingSession.insert(true);
        if OpenTrainingSessionCard then begin
            JCATrainingSession.OpenCard();
        end;
    end;

    procedure CloseTrainingSession(var JCATrainingSession: record "JCA Training Session")
    begin
        JCATrainingSession.Validate(Status, JCATrainingSession.Status::Closed);
        JCATrainingSession.modify(true);
    end;
}
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

    procedure FectchTrainingSessionParticipants(var JCATrainingSession: record "JCA Training Session")
    var
        JCATrainingGroupMember: record "JCA Training Group Member";
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
    begin
        JCATrainingSession.TestField(Status, JCATrainingSession.Status::Open);
        JCATrainingSession.TestField("Training Group Code");

        JCATrainingGroupMember.Reset();
        JCATrainingGroupMember.setrange("Training Group Code", JCATrainingSession."Training Group Code");
        if JCATrainingGroupMember.findset() then
            repeat
                JCATrSessionParticipant.reset();
                JCATrSessionParticipant.setrange("Training Session ID", JCATrainingSession.ID);
                JCATrSessionParticipant.SetRange("Member License ID", JCATrainingGroupMember."Member License ID");
                if JCATrSessionParticipant.IsEmpty() then begin
                    JCATrSessionParticipant.Reset();
                    JCATrSessionParticipant.init();
                    JCATrSessionParticipant.validate("Training Session ID", JCATrainingSession.ID);
                    JCATrSessionParticipant.validate("Member License ID", JCATrainingGroupMember."Member License ID");
                    JCATrSessionParticipant.insert(true);
                end;
            until JCATrainingGroupMember.Next() = 0;
    end;
}
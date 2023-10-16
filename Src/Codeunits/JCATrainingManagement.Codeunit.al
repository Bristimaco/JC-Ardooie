codeunit 50101 "JCA Training Management"
{
    procedure CreateNewTrainingSession(OpenTrainingSessionCard: Boolean)
    var
        JCATrainingSession: Record "JCA Training Session";
    begin
        JCATrainingSession.Reset();
        JCATrainingSession."No." := '';
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
        JCAGuestMember: record "JCA Member";
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
        JCAClub: record "JCA Club";
    begin
        JCATrainingSession.TestField(Status, JCATrainingSession.Status::Open);
        JCATrainingSession.TestField("Training Group Code");

        JCAClub.Reset();
        JCAClub.setrange("Our Club", true);
        JCAClub.findfirst();

        JCATrainingGroupMember.Reset();
        JCATrainingGroupMember.setrange("Training Group Code", JCATrainingSession."Training Group Code");
        if JCATrainingGroupMember.findset() then
            repeat
                JCATrSessionParticipant.reset();
                JCATrSessionParticipant.setrange("Training Session No.", JCATrainingSession."No.");
                JCATrSessionParticipant.SetRange("Member License ID", JCATrainingGroupMember."Member License ID");
                if JCATrSessionParticipant.IsEmpty() then begin
                    JCATrSessionParticipant.Reset();
                    JCATrSessionParticipant.init();
                    JCATrSessionParticipant.validate("Club Member", true);
                    JCATrSessionParticipant.validate("Training Session No.", JCATrainingSession."No.");
                    JCATrSessionParticipant.validate("Member License ID", JCATrainingGroupMember."Member License ID");
                    JCATrSessionParticipant.validate("Club No.", JCAClub."No.");
                    JCATrSessionParticipant.insert(true);
                end;
            until JCATrainingGroupMember.Next() = 0;
    end;

    procedure FetchTrainingSessionParticipantsFromOtherClubs(var JCATrainingSession: Record "JCA Training Session")
    var
        JCAGuestMemberTrGroup: record "JCA Guest Member Tr. Group";
        JCAGuestMember: record "JCA Guest Member";
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
        JCAClub: record "JCA Club";
    begin
        JCATrainingSession.TestField(Status, JCATrainingSession.Status::Open);
        JCATrainingSession.TestField("Training Group Code");

        JCAGuestMemberTrGroup.Reset();
        JCAGuestMemberTrGroup.setrange("Training Group Code", JCATrainingSession."Training Group Code");
        JCAGuestMemberTrGroup.setrange(Active, true);
        if JCAGuestMemberTrGroup.findset() then
            repeat
                JCAGuestMember.Reset();
                JCAGuestMember.Get(JCAGuestMemberTrGroup."Guest Member License ID");
                if JCAGuestMember.Active then begin
                    JCATrSessionParticipant.reset();
                    JCATrSessionParticipant.setrange("Training Session No.", JCATrainingSession."No.");
                    JCATrSessionParticipant.SetRange("Member License ID", JCAGuestMemberTrGroup."Guest Member License ID");
                    if JCATrSessionParticipant.IsEmpty() then begin
                        JCATrSessionParticipant.Reset();
                        JCATrSessionParticipant.init();
                        JCATrSessionParticipant.validate("Club Member", false);
                        JCATrSessionParticipant.validate("Training Session No.", JCATrainingSession."No.");
                        JCATrSessionParticipant.validate("Member License ID", JCAGuestMemberTrGroup."Guest Member License ID");
                        JCATrSessionParticipant.validate("Club No.", JCAGuestMember."Club No.");
                        JCATrSessionParticipant.insert(true);
                    end;
                end;
            until JCAGuestMemberTrGroup.Next() = 0;
    end;

    procedure ProcessTrainingAttendeeScan(TrainingSessionNo: code[20]; AttendeeLicenseID: code[20])
    var
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
        NotAbleToParticipateErr: label 'You are not registered as a participant for this training, please contact a supervisor.';
        UnRegisterFromTrainingSessionQst: label 'You are already registered for this training session, do you want to unregister?';
    begin
        JCATrSessionParticipant.Reset();
        JCATrSessionParticipant.SetRange("Training Session No.", TrainingSessionNo);
        JCATrSessionParticipant.Setrange("Member License ID", AttendeeLicenseID);
        if not JCATrSessionParticipant.findfirst() then begin
            Message(NotAbleToParticipateErr);
            exit;
        end;

        if JCATrSessionParticipant.Participation then
            if not confirm(UnRegisterFromTrainingSessionQst) then
                exit;

        JCATrSessionParticipant.Participation := not JCATrSessionParticipant.Participation;
        JCATrSessionParticipant.modify(true);
    end;
}
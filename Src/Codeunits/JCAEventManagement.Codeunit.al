codeunit 50102 "JCA Event Management"
{
    procedure CreateNewEvent(OpenEventCard: Boolean)
    var
        JCAEvent: Record "JCA Event";
    begin
        JCAEvent.Reset();
        JCAEvent.ID := 0;
        JCAEvent.insert(true);
        if OpenEventCard then begin
            JCAEvent.OpenCard();
        end;
    end;

    procedure FetchEventParticipants(var JCAEvent: Record "JCA Event")
    var
        JCAEventAgeGroup: Record "JCA Event Age Group";
        JCAMemberAgeGroup: record "JCA Member Age Group";
        JCAAgeGroup: record "JCA Age Group";
        JCAEventParticipant: record "JCA Event Participant";
    begin
        JCAEventAgeGroup.Reset();
        JCAEventAgeGroup.setrange("Event ID", JCAEvent.ID);
        if JCAEventAgeGroup.Findset() then
            repeat
                JCAAgeGroup.Reset();
                JCAAgeGroup.setrange("Country Code", JCAEventAgeGroup."Country Code");
                JCAAgeGroup.setrange(Gender, JCAEventAgeGroup.Gender);
                JCAAgeGroup.setrange(Code, JCAEventAgeGroup."Age Group Code");
                if JCAAgeGroup.findfirst() then
                    if JCAAgeGroup.GetAgeGroupMembers(JCAMemberAgeGroup) then
                        repeat
                            JCAEventParticipant.Reset();
                            JCAEventParticipant.setrange("Event ID", JCAEvent.ID);
                            JCAEventParticipant.setrange("Member License ID", JCAMemberAgeGroup."Member License ID");
                            if JCAEventParticipant.IsEmpty() then begin
                                JCAEventParticipant.Reset();
                                JCAEventParticipant.init();
                                JCAEventParticipant.Validate("Event ID", JCAEvent.ID);
                                JCAEventParticipant.validate("Member License ID", JCAMemberAgeGroup."Member License ID");
                                JCAEventParticipant.Validate("Age Group Code", JCAMemberAgeGroup."Age Group Code");
                                JCAEventParticipant.insert(true);
                            end;
                        until JCAMemberAgeGroup.Next() = 0;
            until JCAEventAgeGroup.Next() = 0;
    end;

    procedure SendEventInvitations(JCAEvent: Record "JCA Event")
    begin
        InviteEventSupervisors(JCAEvent);
        InvitePotentialParticipants(JCAEvent);
        Message('All Invitations have been sent, please check if everyone has been invited');
    end;

    local procedure InviteEventSupervisors(JCAEvent: record "JCA Event")
    var
        JCAEventSupervisor: record "JCA Event Supervisor";
    begin
        JCAEventSupervisor.Reset();
        JCAEventSupervisor.setrange("Event ID", JCAEvent.ID);
        if JCAEventSupervisor.findset() then
            repeat
                if SendEventInvitationMail(JCAEventSupervisor."Member License ID", JCAEvent) then begin
                    JCAEventSupervisor.validate(Invited, true);
                    JCAEventSupervisor.Modify(true);
                end;
            until JCAEventSupervisor.Next() = 0;
    end;

    local procedure InvitePotentialParticipants(JCAEvent: record "JCA Event")
    var
        JCAEventParticipant: record "JCA Event Participant";
    begin
        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Event ID", JCAEvent.ID);
        if JCAEventParticipant.findset() then
            repeat
                if SendEventInvitationMail(JCAEventParticipant."Member License ID", JCAEvent) then begin
                    JCAEventParticipant.validate(Invited, true);
                    JCAEventParticipant.modify();
                end;
            until JCAEventParticipant.Next() = 0;
    end;

    local procedure SendEventInvitationMail(MemberLicenseID: code[20]; JCAEvent: record "JCA Event"): Boolean
    var
        JCAMailManagement: Codeunit "JCA Mail Management";
    begin
        Clear(JCAMailManagement);
        exit(JCAMailManagement.SendEventInvitationMail(MemberLicenseID, JCAEvent));
    end;
}
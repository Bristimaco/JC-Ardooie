codeunit 50102 "JCA Event Management"
{
    procedure CreateNewEvent(OpenEventCard: Boolean)
    var
        JCAEvent: Record "JCA Event";
    begin
        JCAEvent.Reset();
        JCAEvent."No." := '';
        JCAEvent.insert(true);
        if OpenEventCard then
            JCAEvent.OpenCard();
    end;

    procedure FetchEventParticipants(var JCAEvent: Record "JCA Event")
    var
        JCAEventAgeGroup: Record "JCA Event Age Group";
        JCAMember: record "JCA Member";
        tempJCAMemberAgeGroup: record "JCA Member Age Group" temporary;
        JCAAgeGroup: record "JCA Age Group";
        JCAEventParticipant: record "JCA Event Participant";
    begin
        JCAEventAgeGroup.Reset();
        JCAEventAgeGroup.setrange("Event No.", JCAEvent."No.");
        if JCAEventAgeGroup.Findset() then
            repeat
                JCAAgeGroup.Reset();
                JCAAgeGroup.setrange("Country Code", JCAEventAgeGroup."Country Code");
                JCAAgeGroup.setrange(Gender, JCAEventAgeGroup.Gender);
                JCAAgeGroup.setrange(Code, JCAEventAgeGroup."Age Group Code");
                if JCAAgeGroup.findfirst() then
                    if JCAAgeGroup.GetAgeGroupMembers(tempJCAMemberAgeGroup, JCAEvent.Date) then
                        repeat
                            JCAMember.get(tempJCAMemberAgeGroup."Member License ID");
                            if JCAMember.HasActiveMembership(JCAEvent.Date) then begin
                                JCAEventParticipant.Reset();
                                JCAEventParticipant.setrange("Event No.", JCAEvent."No.");
                                JCAEventParticipant.setrange("Member License ID", tempJCAMemberAgeGroup."Member License ID");
                                if JCAEventParticipant.IsEmpty() then begin
                                    JCAEventParticipant.Reset();
                                    JCAEventParticipant.init();
                                    JCAEventParticipant.Validate("Event No.", JCAEvent."No.");
                                    JCAEventParticipant.validate("Member License ID", tempJCAMemberAgeGroup."Member License ID");
                                    JCAEventParticipant.Validate("Age Group Code", tempJCAMemberAgeGroup."Age Group Code");
                                    JCAEventParticipant.insert(true);
                                end;
                            end;
                        until tempJCAMemberAgeGroup.Next() = 0;
            until JCAEventAgeGroup.Next() = 0;
    end;

    procedure SendEventInvitations(JCAEvent: Record "JCA Event")
    var
        AllInvitationsHaveBeenSentMsg: label 'All invitations have been sent.';
    begin
        InviteEventSupervisors(JCAEvent);
        InvitePotentialParticipants(JCAEvent);
        Message(AllInvitationsHaveBeenSentMsg);
    end;

    procedure SendEventInvitationReminders(JCAEvent: record "JCA Event")
    begin
        CheckEventContent(JCAEvent);
        RemindEventSupervisors(JCAEvent);
        RemindPotentialParticipants(JCAEvent);
    end;

    local procedure CheckEventContent(JCAEvent: Record "JCA Event")
    var
        JCAEventSupervisor: record "JCA Event Supervisor";
        JCAEventParticipant: record "JCA Event Participant";
        NoSupervisorsInEventErr: label 'There are no supervisors in the Event';
        NoParticipantsInEventErr: label 'There are no participants in the Event';
    begin
        JCAEventSupervisor.Reset();
        JCAEventSupervisor.setrange("Event No.", JCAEvent."No.");
        if JCAEventSupervisor.isempty() then
            error(NoSupervisorsInEventErr);

        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Event No.", JCAEvent."No.");
        if JCAEventParticipant.IsEmpty() then
            error(NoParticipantsInEventErr);
    end;

    local procedure InviteEventSupervisors(JCAEvent: record "JCA Event")
    var
        JCAEventSupervisor: record "JCA Event Supervisor";
    begin
        JCAEventSupervisor.Reset();
        JCAEventSupervisor.setrange("Event No.", JCAEvent."No.");
        JCAEventSupervisor.setrange(Invited, false);
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
        JCAEventParticipant.setrange("Event No.", JCAEvent."No.");
        JCAEventParticipant.setrange(Invited, false);
        if JCAEventParticipant.findset() then
            repeat
                if SendEventInvitationMail(JCAEventParticipant."Member License ID", JCAEvent) then begin
                    JCAEventParticipant.validate(Invited, true);
                    JCAEventParticipant.modify();
                end;
            until JCAEventParticipant.Next() = 0;
    end;

    local procedure RemindEventSupervisors(JCAEvent: record "JCA Event")
    var
        JCAEventSupervisor: record "JCA Event Supervisor";
    begin
        JCAEventSupervisor.Reset();
        JCAEventSupervisor.setrange("Event No.", JCAEvent."No.");
        JCAEventSupervisor.setrange("Applied for Registration", false);
        JCAEventSupervisor.setrange(Invited, true);
        if JCAEventSupervisor.findset() then
            repeat
                if SendEventReminderMail(JCAEventSupervisor."Member License ID", JCAEvent) then begin
                    JCAEventSupervisor.validate(Invited, true);
                    JCAEventSupervisor.Modify(true);
                end;
            until JCAEventSupervisor.Next() = 0;
    end;

    local procedure RemindPotentialParticipants(JCAEvent: record "JCA Event")
    var
        JCAEventParticipant: record "JCA Event Participant";
    begin
        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Event No.", JCAEvent."No.");
        JCAEventParticipant.setrange("Applied for Registration", false);
        JCAEventParticipant.setrange(Invited, true);
        if JCAEventParticipant.findset() then
            repeat
                if SendEventReminderMail(JCAEventParticipant."Member License ID", JCAEvent) then begin
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

    local procedure SendEventReminderMail(MemberLicenseID: code[20]; JCAEvent: record "JCA Event"): Boolean
    var
        JCAMailManagement: Codeunit "JCA Mail Management";
    begin
        Clear(JCAMailManagement);
        exit(JCAMailManagement.SendEventReminderMail(MemberLicenseID, JCAEvent));
    end;

    procedure CheckParticipantsAndSupervistors(var JCAEvent: record "JCA Event")
    begin
        case JCAEvent.Status of
            enum::"JCA Event Status"::"Invitations Sent", enum::"JCA Event Status"::"Open for Registrations":
                CheckAllInvitationsSent(JCAEvent);
            enum::"JCA Event Status"::"Registrations Closed":
                CheckParticipantAndSupervisorRegistrationApplications(JCAEvent);
            enum::"JCA Event Status"::"Registrations Processed":
                CheckParticipantAndSupervisorRegistrations(JCAEvent);
        end;
    end;

    local procedure CheckAllInvitationsSent(var JCAEvent: record "JCA Event")
    var
        JCAEventParticipant: record "JCA Event Participant";
        JCAEventSupervisor: record "JCA Event Supervisor";
        NoParticipantsInEventErr: label 'There are no participants in the Event';
        NoSupervisorsInEventErr: label 'There are no supervisors in the Event';
        ProceedWithUninvitedParticipantsQst: label 'There are participants in the event that have not been invited, do you want to continue?';
        ProceedWithUninvitedSupervisorsQst: label 'There are supervisors in the event that have not been invited, do you want to continue?';
    begin
        if JCAEvent.GetParticipants(JCAEventParticipant) then begin
            JCAEventParticipant.setrange(Invited, false);
            if not JCAEventParticipant.IsEmpty() then
                if not confirm(ProceedWithUninvitedParticipantsQst) then
                    error('')
                else
                    JCAEventParticipant.Deleteall(true);
        end else
            error(NoParticipantsInEventErr);

        if not JCAEvent.GetSupervisors(JCAEventSupervisor) then
            error(NoSupervisorsInEventErr);
        JCAEventSupervisor.setrange(Invited, false);
        if not JCAEventSupervisor.IsEmpty() then
            if not confirm(ProceedWithUninvitedSupervisorsQst) then
                error('')
            else
                JCAEventSupervisor.DeleteAll(true);
    end;

    local procedure CheckParticipantAndSupervisorRegistrationApplications(var JCAEvent: record "JCA Event")
    var
        JCAEventParticipant: record "JCA Event Participant";
        JCAEventSupervisor: record "JCA Event Supervisor";
        ProceedWithUnAppliedParticipantsQst: label 'There are participants in the event that have not applied for registration, do you want to continue?';
        ProceedWithUnAppliedSupervisorsQst: label 'There are supervisors in the event that have not applied for registration, do you want to continue?';
    begin
        if JCAEvent.GetParticipants(JCAEventParticipant) then begin
            JCAEventParticipant.setrange("Applied for Registration", false);
            if not JCAEventParticipant.IsEmpty() then
                if not Confirm(ProceedWithUnAppliedParticipantsQst) then
                    error('')
                else
                    JCAEventParticipant.deleteall(true);
        end;

        if JCAEvent.GetSupervisors(JCAEventSupervisor) then begin
            JCAEventSupervisor.setrange("Applied for Registration", false);
            if not JCAEventSupervisor.IsEmpty() then
                if not confirm(ProceedWithUnAppliedSupervisorsQst) then
                    error('')
                else
                    JCAEventSupervisor.DeleteAll(true);
        end;
    end;

    local procedure CheckParticipantAndSupervisorRegistrations(var JCAEvent: record "JCA Event")
    var
        JCAEventParticipant: record "JCA Event Participant";
        JCAEventSupervisor: record "JCA Event Supervisor";
        ProceedWithUnregisteredParticipantsQst: label 'There are participants in the event that are not registered, do you want to continue?';
        ProceedWithUregisteredSupervisorsQst: label 'There are supervisors in the event that are not registered, do you want to continue?';
    begin
        if JCAEvent.GetParticipants(JCAEventParticipant) then begin
            JCAEventParticipant.setrange(Registered, false);
            if not JCAEventParticipant.IsEmpty() then
                if not Confirm(ProceedWithUnregisteredParticipantsQst) then
                    error('')
                else
                    JCAEventParticipant.deleteall(true);
        end;

        if JCAEvent.GetSupervisors(JCAEventSupervisor) then begin
            JCAEventSupervisor.setrange(registered, false);
            if not JCAEventSupervisor.IsEmpty() then
                if not confirm(ProceedWithUregisteredSupervisorsQst) then
                    error('')
                else
                    JCAEventSupervisor.DeleteAll(true);
        end;
    end;
}
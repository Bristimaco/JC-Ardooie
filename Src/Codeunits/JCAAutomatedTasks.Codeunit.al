codeunit 50100 "JCA Automated Tasks"
{
    trigger OnRun()
    begin
        UpdateAgeGroupsOnMembers();
        UpdateTrainingGroups();
        CreateMembershipRenewals();
        SendInvitationReminders();
    end;

    procedure UpdateAgeGroupsOnMembers()
    var
        JCAMember: record "JCA Member";
        tempJCAMemberAgeGroup: record "JCA Member Age Group" temporary;
    begin
        JCAMember.Reset();
        if JCAMember.FindSet() then
            repeat
                JCAMember.UpdateAgeGroups(today(), true, tempJCAMemberAgeGroup);
            until JCAMember.Next() = 0;
    end;

    procedure UpdateTrainingGroups()
    var
        JCAMember: record "JCA Member";
    begin
        JCAMember.Reset();
        if JCAMember.findset() then
            repeat
                JCAMember.SetFilter("Membersh. Start Date Filter", '<=%1', Today());
                JCAMember.SetFilter("Membersh. End Date Filter", '>=%1', Today());
                JCAMember.CalcFields("Active Membership");
                if JCAMember."Active Membership" = '' then
                    JCAMember.RemoveFromTrainingGroups();
            until JCAMember.Next() = 0;
    end;

    procedure CreateMembershipRenewals()
    var
        JCAMemberManagement: codeunit "JCA Member Management";
    begin
        clear(JCAMemberManagement);
        JCAMemberManagement.CreateMembershipRenewals();
    end;

    procedure SendInvitationReminders()
    var
        JCAEvent: Record "JCA Event";
        JCASetup: Record "JCA Setup";
        EmptyDateFormula: DateFormula;
        LastReminderDate: Date;
    begin
        JCASetup.Reset();
        JCASetup.get();
        if EmptyDateFormula = JCASetup."Invitation Reminder Period" then
            exit;
        LastReminderDate := CalcDate(JCASetup."Invitation Reminder Period", Today());

        JCAEvent.Reset();
        JCAEvent.setrange(status, JCAEvent.status::"Invitations Sent", JCAEvent.status::"Open for Registrations");
        JCAEvent.setrange("Send Invitation Reminders", true);
        JCAEvent.setfilter("Last Reminder Mail Sent On", '<=%1', LastReminderDate);
        if JCAEvent.findset() then
            repeat
                JCAEvent.SendInvitationReminders();
            until JCAEvent.Next() = 0;
    end;
}
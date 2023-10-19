codeunit 50100 "JCA Daily Updates"
{
    trigger OnRun()
    begin
        UpdateAgeGroupsOnMembers();
        UpdateTrainingGroups();
        CreateMembershipRenewals();
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
}
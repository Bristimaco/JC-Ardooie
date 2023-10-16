codeunit 50100 "JCA Daily Updates"
{
    trigger OnRun()
    begin
        UpdateAgeGroupsOnMembers();
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
                JCAMember.modify(true);
            until JCAMember.Next() = 0;
    end;
}
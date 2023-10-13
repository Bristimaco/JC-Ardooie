codeunit 50100 "JCA Daily Updates"
{
    trigger OnRun()
    begin
        UpdateAgeGroupsOnMembers();
    end;

    procedure UpdateAgeGroupsOnMembers()
    var
        JCAMember: record "JCA Member";
    begin
        JCAMember.Reset();
        if JCAMember.FindSet() then
            repeat
                JCAMember.UpdateAgeGroups();
                JCAMember.modify(true);
            until JCAMember.Next() = 0;
    end;
}
codeunit 50100 "JCA Daily Updates"
{
    trigger OnRun()
    begin
        UpdateAgeGroupOnMembers();
    end;

    local procedure UpdateAgeGroupOnMembers()
    var
        JCAMember: record "JCA Member";
    begin
        JCAMember.Reset();
        JCAMember.SetFilter("Date of Birth", '<>%1', 0D);
        if JCAMember.FindSet() then
            repeat
                UpdateAgeGroupOnMember(JCAMember);
            until JCAMember.Next() = 0;
    end;

    local procedure UpdateAgeGroupOnMember(var JCAMember: record "JCA Member")
    var
        CurrentJCAAgeGroup: record "JCA Age Group";
        CurrentAge: Integer;
    begin
        if JCAMember.GetCurrentAgeGroup(CurrentJCAAgeGroup, CurrentAge, '') then begin
            JCAMember.validate(Age, CurrentAge);
            JCAMember.Validate("Age Group Code", CurrentJCAAgeGroup.Code);
            JCAMember.modify(true);
        end;
    end;
}
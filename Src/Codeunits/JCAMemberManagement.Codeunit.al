codeunit 50103 "JCA Member Management"
{
    procedure UpdateAgeGroups(var JCAMember: record "JCA Member")
    var
        JCAAgeGroup: record "JCA Age Group";
        CountryRegion: record "Country/Region";
        JCAMemberAgeGroup: record "JCA Member Age Group";
        CurrentAge: Integer;
    begin
        JCAMemberAgeGroup.Reset();
        JCAMemberAgeGroup.setrange("Member License ID", JCAMember."License ID");
        JCAMemberAgeGroup.DeleteAll(true);

        if not (JCAMember."Member Type" in [JCAMember."Member Type"::Judoka, JCAMember."Member Type"::Both]) then
            exit;

        CountryRegion.Reset();
        if CountryRegion.Findset() then
            repeat
                if GetCurrentAgeGroup(JCAMember, JCAAgeGroup, CurrentAge, CountryRegion.Code) then
                    if CurrentAge <> 0 then begin
                        JCAMember.validate(Age, CurrentAge);
                        JCAMemberAgeGroup.Reset();
                        JCAMemberAgeGroup.init();
                        JCAMemberAgeGroup.validate("Member License ID", JCAMember."License ID");
                        JCAMemberAgeGroup.Validate("Country Code", CountryRegion.code);
                        JCAMemberAgeGroup.calcfields(Gender);
                        JCAMemberAgeGroup.validate("Age Group Code", JCAAgeGroup.Code);
                        JCAMemberAgeGroup.Insert(True);
                    end;
            until CountryRegion.Next() = 0;
    end;

    local procedure GetCurrentAgeGroup(var JCAMember: record "JCA Member"; var JCAAgeGroup: record "JCA Age Group"; var CurrentAge: Integer; CountryCode: code[10]): Boolean
    var
        CountryRegion: record "Country/Region";
        AgeGroupSwitchDate: Date;
        AgeSwitchMonth: Integer;
        PastAgeLimitSwitchDate: Boolean;
        Birthyear: integer;
        Currentyear: Integer;
    begin
        CurrentAge := 0;
        if JCAMember."Date of Birth" = 0D then
            exit(false);

        if CountryCode = '' then
            AgeSwitchMonth := 1
        else begin
            CountryRegion.Reset();
            CountryRegion.get(CountryCode);
            AgeSwitchMonth := CountryRegion."JCA Age Group Switch Month";
        end;
        AgeGroupSwitchDate := DMY2Date(1, AgeSwitchMonth, Date2DMY(Today(), 3));

        PastAgeLimitSwitchDate := false;
        if AgeGroupSwitchDate >= JCAMember."Date of Birth" then
            PastAgeLimitSwitchDate := true;

        Birthyear := Date2DMY(JCAMember."Date of Birth", 3);
        Currentyear := Date2DMY(Today(), 3);
        CurrentAge := Currentyear - Birthyear;

        JCAAgeGroup.Reset();
        JCAAgeGroup.SetCurrentKey("Country Code", Gender, "Max Age");
        JCAAgeGroup.setrange(Gender, JCAMember.Gender);
        JCAAgeGroup.setrange("Country Code", CountryCode);
        JCAAgeGroup.SetFilter("Max Age", '>%1', CurrentAge - 1);
        exit(JCAAgeGroup.FindFirst());
    end;
}
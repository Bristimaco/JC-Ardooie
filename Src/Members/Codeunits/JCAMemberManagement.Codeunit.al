codeunit 50103 "JCA Member Management"
{
    procedure UpdateAgeGroups(var JCAMember: record "JCA Member"; CalculationDate: date; SaveData: Boolean; var tempJCAMemberAgeGroup: record "JCA Member Age Group" temporary)
    var
        JCAAgeGroup: record "JCA Age Group";
        CountryRegion: record "Country/Region";
        JCAMemberAgeGroup: record "JCA Member Age Group";
        CalculateAtDate: Date;
        CurrentAge: Integer;
    begin
        tempJCAMemberAgeGroup.Reset();
        tempJCAMemberAgeGroup.deleteall();

        if CalculationDate <> 0D then
            CalculateAtDate := CalculationDate
        else
            CalculateAtDate := Today();

        if not (JCAMember."Member Type" in [JCAMember."Member Type"::Judoka, JCAMember."Member Type"::Both]) then
            exit;

        CountryRegion.Reset();
        if CountryRegion.Findset() then
            repeat
                if GetCurrentAgeGroup(JCAMember, CalculateAtDate, JCAAgeGroup, CurrentAge, CountryRegion.Code) then
                    if CurrentAge <> 0 then begin
                        if SaveData then begin
                            JCAMember.validate(Age, CurrentAge);
                            if not JCAMember.Modify(true) then
                                JCAMember.insert(true);
                        end;
                        if JCAAgeGroup.Findset() then
                            repeat
                                tempJCAMemberAgeGroup.Reset();
                                tempJCAMemberAgeGroup.init();
                                tempJCAMemberAgeGroup.validate("Member License ID", JCAMember."License ID");
                                tempJCAMemberAgeGroup.Validate("Country Code", CountryRegion.code);
                                tempJCAMemberAgeGroup.calcfields(Gender);
                                tempJCAMemberAgeGroup.validate("Age Group Code", JCAAgeGroup.Code);
                                tempJCAMemberAgeGroup.Insert(True);
                            until JCAAgeGroup.Next() = 0;
                    end;
            until CountryRegion.Next() = 0;

        if SaveData then begin
            JCAMemberAgeGroup.Reset();
            JCAMemberAgeGroup.setrange("Member License ID", JCAMember."License ID");
            JCAMemberAgeGroup.DeleteAll(true);

            if tempJCAMemberAgeGroup.findset() then
                repeat
                    JCAMemberAgeGroup.reset();
                    JCAMemberAgeGroup.init();
                    JCAMemberAgeGroup.TransferFields(tempJCAMemberAgeGroup);
                    JCAMemberAgeGroup.insert(true);
                until tempJCAMemberAgeGroup.Next() = 0;
        end;
    end;

    local procedure GetCurrentAgeGroup(var JCAMember: record "JCA Member"; CalculateAtDate: date; var JCAAgeGroup: record "JCA Age Group"; var CurrentAge: Integer; CountryCode: code[10]): Boolean
    var
        CountryRegion: record "Country/Region";
        AgeGroupSwitchDate: Date;
        AgeSwitchMonth: Integer;
        PastAgeLimitSwitchDate: Boolean;
        Birthyear: integer;
        Currentyear: Integer;
        CalculationDate: Date;
    begin
        CurrentAge := 0;

        if CalculateAtDate <> 0D then
            CalculationDate := CalculateAtDate
        else
            CalculationDate := today();

        if JCAMember."Date of Birth" = 0D then
            exit(false);

        if CountryCode = '' then
            AgeSwitchMonth := 1
        else begin
            CountryRegion.Reset();
            CountryRegion.get(CountryCode);
            AgeSwitchMonth := CountryRegion."JCA Age Group Switch Month";
        end;
        AgeGroupSwitchDate := DMY2Date(1, AgeSwitchMonth, Date2DMY(CalculationDate, 3));

        PastAgeLimitSwitchDate := false;
        if AgeGroupSwitchDate >= JCAMember."Date of Birth" then
            PastAgeLimitSwitchDate := true;

        // TODO: make use of the pastagelimitswichtdate value
        Birthyear := Date2DMY(JCAMember."Date of Birth", 3);
        Currentyear := Date2DMY(CalculationDate, 3);
        CurrentAge := Currentyear - Birthyear;

        JCAAgeGroup.Reset();
        JCAAgeGroup.SetCurrentKey("Country Code", Gender, "Maximum Age");
        JCAAgeGroup.setrange(Gender, JCAMember.Gender);
        JCAAgeGroup.setrange("Country Code", CountryCode);
        JCAAgeGroup.SetFilter("Maximum Age", '>%1', CurrentAge - 1);
        JCAAgeGroup.setfilter("Minimum Age", '<=%1', CurrentAge);
        exit(JCAAgeGroup.Findset());
    end;

    procedure CreateMembershipRenewals()
    var
        JCAMember: record "JCA Member";
    begin
        JCAMember.Reset();
        if JCAMember.findset() then
            repeat
                JCAMember.CreateMembershipRenewal();
            until JCAMember.Next() = 0;
    end;

    procedure CreateMembershipRenewal(var JCAMember: record "JCA Member")
    var
        JCAMembershipPeriod: record "JCA Membership Period";
        JCAMemberShip: record "JCA Membership";
        JCASetup: Record "JCA Setup";
        RenewalDate: Date;
        newRequestStartDate: Date;
        RequestNewMembership: Boolean;
    begin
        JCASetup.Reset();
        JCASetup.get();
        JCASetup.testfield("Membership Renewal Period");
        RenewalDate := CalcDate(JCASetup."Membership Renewal Period", today());

        JCAMember.SetFilter("Membersh. Start Date Filter", '<=%1', Today());
        JCAMember.SetFilter("Membersh. End Date Filter", '>=%1', Today());
        JCAMember.calcfields("Active Membership");
        JCAMember.calcfields("Open Membership Payment Req.");
        if not JCAMember."Open Membership Payment Req." then begin
            if JCAMember."Active Membership" <> '' then begin
                JCAMembershipPeriod.Reset();
                JCAMembershipPeriod.setrange("Member License ID", JCAMember."License ID");
                JCAMembershipPeriod.Setfilter("Membership Starting Date", '<=%1', today());
                JCAMembershipPeriod.Setfilter("Membership Ending Date", '>=%1', today());
                JCAMembershipPeriod.setrange("Membership Payed", true);
                JCAMembershipPeriod.setrange("Membership Code", JCAMember."Active Membership");
                JCAMembershipPeriod.findfirst();
                newRequestStartDate := calcdate('<1D>', JCAMembershipPeriod."Membership Ending Date");
                RequestNewMembership := JCAMembershipPeriod."Membership Ending Date" < RenewalDate;
            end else begin
                RequestNewMembership := true;
                newRequestStartDate := today();
            end;

            if RequestNewMembership then begin
                JCAMemberShip.Reset();
                JCAMemberShip.get(JCAMember."Requested Membership Code");

                JCAMembershipPeriod.Reset();
                JCAMembershipPeriod.init();
                JCAMembershipPeriod.validate("Member License ID", JCAMember."License ID");
                JCAMembershipPeriod.validate("Membership Code", JCAMemberShip.Code);
                JCAMembershipPeriod.validate("Payment Requested On", CurrentDateTime);
                JCAMembershipPeriod.Validate("Membership Starting Date", newRequestStartDate);
                JCAMembershipPeriod.CalculateEndDate();
                JCAMembershipPeriod.insert(true);
            end;
        end;
    end;
}
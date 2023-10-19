codeunit 50106 "JCA Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InstallMemberships();
    end;

    local procedure InstallMemberships()
    var
        JCAMember: record "JCA Member";
        JCAMembershipPeriod: Record "JCA Membership Period";
    begin
        JCAMember.Reset();
        if JCAMember.findset() then
            repeat
                JCAMembershipPeriod.Reset();
                JCAMembershipPeriod.setrange("Member License ID", JCAMember."License ID");
                if JCAMembershipPeriod.IsEmpty() then begin
                    JCAMembershipPeriod.Reset();
                    JCAMembershipPeriod.init();
                    JCAMembershipPeriod.validate("Member License ID", JCAMember."License ID");
                    JCAMembershipPeriod.validate("Membership Code", 'ALGEMEEN');
                    JCAMembershipPeriod.validate("Payment Requested On", CurrentDateTime());
                    JCAMembershipPeriod.Validate("Membership Payed", true);
                    JCAMembershipPeriod.validate("Membership Starting Date", DMY2Date(1, 1, 2023));
                    JCAMembershipPeriod.Validate("Membership Ending Date", DMY2Date(31, 12, 2023));
                    JCAMembershipPeriod.insert(true);
                end;
            until JCAMember.Next() = 0;
    end;
}
codeunit 50106 "JCA Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InstallMemberships();
        ManageResultImages();
        ManageMailMessageTemplates();
        ManageHTMLGeneratorCSSTypes();
    end;

    local procedure InstallMemberships()
    var
        JCAMember: record "JCA Member";
        JCASetup: Record "JCA Setup";
        JCAMembershipPeriod: Record "JCA Membership Period";
    begin
        JCASetup.Reset();
        JCASetup.Get();

        JCAMember.Reset();
        if JCAMember.findset() then
            repeat
                if JCAMember."Requested Membership Code" = '' then begin
                    JCAMember."Requested Membership Code" := JCASetup."Default Membership Code";
                    JCAMember.modify();
                end;

                JCAMembershipPeriod.Reset();
                JCAMembershipPeriod.setrange("Member License ID", JCAMember."License ID");
                if JCAMembershipPeriod.IsEmpty() then begin
                    JCAMembershipPeriod.Reset();
                    JCAMembershipPeriod.init();
                    JCAMembershipPeriod.validate("Member License ID", JCAMember."License ID");
                    JCAMembershipPeriod.validate("Membership Code", JCASetup."Default Membership Code");
                    JCAMembershipPeriod.validate("Payment Requested On", CurrentDateTime());
                    JCAMembershipPeriod.Validate("Membership Payed", true);
                    JCAMembershipPeriod.validate("Membership Starting Date", DMY2Date(1, 1, 2023));
                    JCAMembershipPeriod.Validate("Membership Ending Date", DMY2Date(31, 12, 2023));
                    JCAMembershipPeriod.insert(true);
                end;
            until JCAMember.Next() = 0;
    end;

    local procedure ManageResultImages()
    var
        JCAResultImage: record "JCA Result Image";
        JCAEventResult: Enum "JCA Event Result";
        CurrJCAEventResult: Enum "JCA Event Result";
        ResultIndex: Integer;
    begin
        foreach ResultIndex in JCAEventResult.Ordinals() do begin
            CurrJCAEventResult := enum::"JCA Event Result".FromInteger(ResultIndex);
            JCAResultImage.Reset();
            if not JCAResultImage.get(CurrJCAEventResult) then begin
                JCAResultImage.Reset();
                JCAResultImage.init();
                JCAResultImage.validate(Result, CurrJCAEventResult);
                JCAResultImage.insert(true);
            end;
        end;
    end;

    local procedure ManageMailMessageTemplates()
    var
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        JCAMailMessageType: Enum "JCA Mail Message Type";
        CurrJCAMailMessageType: Enum "JCA Mail Message Type";
        ResultIndex: Integer;
    begin
        foreach ResultIndex in JCAMailMessageType.Ordinals() do begin
            CurrJCAMailMessageType := enum::"JCA Mail Message Type".FromInteger(ResultIndex);
            JCAMailMessageTemplate.Reset();
            if not JCAMailMessageTemplate.get(CurrJCAMailMessageType) then begin
                JCAMailMessageTemplate.Reset();
                JCAMailMessageTemplate.init();
                JCAMailMessageTemplate.validate("Mail Message Type", CurrJCAMailMessageType);
                JCAMailMessageTemplate.insert(true);
            end;
        end;
    end;

    local procedure ManageHTMLGeneratorCSSTypes()
    var
        JCAHTMLGenCSSTemplate: record "JCA HTML Gen. CSS Template";
        JCAHTMLGenCSSType: Enum "JCA HTML Gen. CSS Type";
        CurrHTMLGenCSSType: Enum "JCA HTML Gen. CSS Type";
        ResultIndex: Integer;
    begin
        foreach ResultIndex in JCAHTMLGenCSSType.Ordinals() do begin
            CurrHTMLGenCSSType := enum::"JCA HTML Gen. CSS Type".FromInteger(ResultIndex);
            JCAHTMLGenCSSTemplate.Reset();
            if not JCAHTMLGenCSSTemplate.get(CurrHTMLGenCSSType) then begin
                JCAHTMLGenCSSTemplate.Reset();
                JCAHTMLGenCSSTemplate.init();
                JCAHTMLGenCSSTemplate.validate("HTML Gen. CSS Type", CurrHTMLGenCSSType);
                JCAHTMLGenCSSTemplate.insert(true);
            end;
        end;
    end;
}
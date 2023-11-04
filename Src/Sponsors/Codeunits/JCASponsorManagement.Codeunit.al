codeunit 50116 "JCA Sponsor Management"
{
    procedure CreateSponsorshipRenewals()
    var
        Customer: record Customer;
    begin
        Customer.Reset();
        if Customer.findset() then
            repeat
                Customer.CreateSponsorshipRenewal();
            until Customer.Next() = 0;
    end;

    procedure CreateSponsorshipRenewal(var Customer: record Customer)
    var
        JCASponsorshipPeriod: record "JCA Sponsorship Period";
        JCASponsorFormula: record "JCA Sponsor Formula";
        JCASetup: Record "JCA Setup";
        RenewalDate: Date;
        newRequestStartDate: Date;
        RequestNewMembership: Boolean;
    begin
        JCASetup.Reset();
        JCASetup.get();
        JCASetup.testfield("Membership Renewal Period");
        RenewalDate := CalcDate(JCASetup."Membership Renewal Period", today());

        Customer.SetFilter("JCA SpSh. Start Date Filter", '<=%1', Today());
        Customer.SetFilter("JCA SpSh. End Date Filter", '>=%1', Today());
        Customer.calcfields("JCA Active Sponsorship");
        if Customer."JCA Active Sponsorship" <> '' then begin
            JCASponsorshipPeriod.Reset();
            JCASponsorshipPeriod.setrange("Sponsor No.", Customer."No.");
            JCASponsorshipPeriod.Setfilter("Sponsorship Starting Date", '<=%1', today());
            JCASponsorshipPeriod.Setfilter("Sponsorship Ending Date", '>=%1', today());
            JCASponsorshipPeriod.setrange("Sponsorship Payed", true);
            JCASponsorshipPeriod.setrange("Sponsorship Code", Customer."JCA Active Sponsorship");
            JCASponsorshipPeriod.findfirst();
            newRequestStartDate := calcdate('<1D>', JCASponsorshipPeriod."Sponsorship Ending Date");
            RequestNewMembership := JCASponsorshipPeriod."Sponsorship Ending Date" < RenewalDate;
        end else begin
            RequestNewMembership := true;
            newRequestStartDate := today();
        end;

        if RequestNewMembership then begin
            // TODO: make invoice
            JCASponsorFormula.Reset();
            JCASponsorFormula.get(Customer."JCA Req. Sponsorship Code");

            JCASponsorshipPeriod.Reset();
            JCASponsorshipPeriod.init();
            JCASponsorshipPeriod.validate("Sponsor No.", Customer."No.");
            JCASponsorshipPeriod.validate("Sponsorship Code", JCASponsorFormula.Code);
            JCASponsorshipPeriod.validate("Payment Requested On", CurrentDateTime);
            JCASponsorshipPeriod.Validate("Sponsorship Starting Date", newRequestStartDate);
            JCASponsorshipPeriod.CalculateEndDate();
            JCASponsorshipPeriod.insert(true);
        end;
    end;
}
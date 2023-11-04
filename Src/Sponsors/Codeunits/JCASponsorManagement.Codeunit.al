codeunit 50116 "JCA Sponsor Management"
{
    procedure CreateSponsorshipRenewals()
    var
        Customer: record Customer;
    begin
        Customer.Reset();
        Customer.setrange("JCA Sponsor", true);
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
        RequestNewSponsorship: Boolean;
    begin
        if not Customer."JCA Sponsor" then
            exit;

        JCASetup.Reset();
        JCASetup.get();
        JCASetup.testfield("Sponsorship Renewal Period");
        RenewalDate := CalcDate(JCASetup."Sponsorship Renewal Period", today());

        Customer.SetFilter("JCA SpSh. Start Date Filter", '<=%1', Today());
        Customer.SetFilter("JCA SpSh. End Date Filter", '>=%1', Today());
        Customer.calcfields("JCA Active Sponsorship");
        Customer.CalcFields("JCA Open SpShip Payment Req.");
        if not customer."JCA Open SpShip Payment Req." then begin
            if Customer."JCA Active Sponsorship" <> '' then begin
                JCASponsorshipPeriod.Reset();
                JCASponsorshipPeriod.setrange("Sponsor No.", Customer."No.");
                JCASponsorshipPeriod.Setfilter("Sponsorship Starting Date", '<=%1', today());
                JCASponsorshipPeriod.Setfilter("Sponsorship Ending Date", '>=%1', today());
                JCASponsorshipPeriod.setrange("Sponsorship Payed", true);
                JCASponsorshipPeriod.setrange("Sponsorship Code", Customer."JCA Active Sponsorship");
                JCASponsorshipPeriod.findfirst();
                newRequestStartDate := calcdate('<1D>', JCASponsorshipPeriod."Sponsorship Ending Date");
                RequestNewSponsorship := JCASponsorshipPeriod."Sponsorship Ending Date" < RenewalDate;
            end else begin
                RequestNewSponsorship := true;
                newRequestStartDate := today();
            end;

            if RequestNewSponsorship then begin
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
    end;
}
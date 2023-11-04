page 50151 "JCA Sponsor Cues"
{
    Caption = 'Sponsors';
    SourceTable = "JCA Cue";
    PageType = CardPart;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(SponsorsCues)
            {
                Caption = 'Sponsors';

                field("Active Sponsors"; Rec."Active Sponsors")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Inactive Sponsors"; Rec."Inactive Sponsors")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
            cuegroup(SponsorshipRenewals)
            {
                Caption = 'Renewals';

                field("Open Sponsorship Payment Req."; Rec."Open Sponsorship Payment Req.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty() then begin
            Rec.init();
            Rec.insert();
        end;
        rec.setfilter("Sponsorship Filter", '<>%1', '');
        rec.SetFilter("Sponsorsh. Start Date Filter", '<=%1', Today());
        rec.SetFilter("Sponsorsh. End Date Filter", '>=%1', Today());
    end;
}
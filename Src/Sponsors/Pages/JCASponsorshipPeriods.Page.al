page 50150 "JCA Sponsorship Periods"
{
    Caption = 'Sponsorship Periods';
    SourceTable = "JCA Sponsorship Period";
    DelayedInsert = true;
    UsageCategory = None;
    PageType = List;
    SourceTableView = sorting("Sponsorship Starting Date") order(descending);

    layout
    {
        area(Content)
        {
            repeater(MembershipPeriods)
            {
                field("Sponsor No."; Rec."Sponsor No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Sponsor Name"; Rec."Sponsor Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Sponsorship Code"; Rec."Sponsorship Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Sponsorship Description"; Rec."Sponsorship Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Sponsorship Fee"; Rec."Sponsorship Fee")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Payment Requested On"; Rec."Payment Requested On")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Sponsorship Payed"; Rec."Sponsorship Payed")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Sponsorship Starting Date"; Rec."Sponsorship Starting Date")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Sponsorship Ending Date"; Rec."Sponsorship Ending Date")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
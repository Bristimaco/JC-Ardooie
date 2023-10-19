page 50135 "JCA Membership Periods"
{
    Caption = 'Membership Periods';
    SourceTable = "JCA Membership Period";
    DelayedInsert = true;
    UsageCategory = None;
    PageType = List;
    SourceTableView = sorting("Membership Starting Date") order(ascending);

    layout
    {
        area(Content)
        {
            repeater(MembershipPeriods)
            {
                field("Membership Code"; Rec."Membership Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Membership Description"; Rec."Membership Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Membership Fee"; Rec."Membership Fee")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Payment Requested On"; Rec."Payment Requested On")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Membership Payed"; Rec."Membership Payed")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Membership Starting Date"; Rec."Membership Starting Date")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Membership Ending Date"; Rec."Membership Ending Date")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
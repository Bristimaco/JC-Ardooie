page 50149 "JCA Sponsor Formulas"
{
    Caption = 'Sponsor Formulas';
    PageType = List;
    SourceTable = "JCA Sponsor Formula";
    ApplicationArea = all;
    UsageCategory = Administration;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(SponsorFormulas)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Membership Period"; Rec."Sponsorship Period")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Voucher Code"; Rec."Voucher Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Voucher Description"; Rec."Voucher Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Sponsors; Rec.Sponsors)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
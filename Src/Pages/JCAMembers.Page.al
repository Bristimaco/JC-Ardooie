page 50101 "JCA Members"
{
    Caption = 'Members';
    SourceTable = "JCA Member";
    ApplicationArea = all;
    UsageCategory = Lists;
    PageType = List;
    CardPageId = "JCA Member Card";

    layout
    {
        area(Content)
        {
            repeater(Members)
            {
                field("License ID"; Rec."License ID")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Member Type"; Rec."Member Type")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Date Filter", '=%1&<%2', 0D, Today());
    end;
}
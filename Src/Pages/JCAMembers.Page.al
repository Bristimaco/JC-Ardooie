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
                field(Belt; Rec.Belt)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }

        area(FactBoxes)
        {
            part(MemberInformation; "JCA Member Factbox")
            {
                Caption = 'Member Information';
                ApplicationArea = all;
                SubPageLink = "License ID" = field("License ID");
                UpdatePropagation = both;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Date Filter", '=%1&<%2', 0D, Today());
    end;
}
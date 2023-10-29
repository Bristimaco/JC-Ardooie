page 50146 "JCA Injuries"
{
    Caption = 'Injuries';
    SourceTable = "JCA Injury";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    DelayedInsert = true;
    CardPageId = "JCA Injury Card";

    layout
    {
        area(Content)
        {
            repeater(Injuries)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Member License ID"; Rec."Member License ID")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Member Full Name"; Rec."Member Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Related To"; Rec."Related To")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Related To No."; Rec."Related To No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Related To Description"; Rec."Related To Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Short Description"; Rec."Short Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Insurance Status"; Rec."Insurance Status")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
page 50118 "JCA Event Age Groups"
{
    Caption = 'Event Age Groups';
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "JCA Event Age Group";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(AgeGroups)
            {
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group Code"; Rec."Age Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group Description"; Rec."Age Group Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Weigh-In Start Time"; Rec."Weigh-In Start Time")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
page 50128 "JCA Event Age Group Lookup"
{
    Caption = 'Event Age Group Lookup';
    PageType = List;
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
            }
        }
    }
}
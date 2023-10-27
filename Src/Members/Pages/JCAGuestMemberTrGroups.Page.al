page 50132 "JCA Guest Member Tr. Groups"
{
    Caption = 'Guest Member Training Groups';
    PageType = ListPart;
    SourceTable = "JCA Guest Member Tr. Group";
    DelayedInsert = true;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(TrainingGroups)
            {
                field("Training Group Code"; Rec."Training Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Training Group Description"; Rec."Training Group Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
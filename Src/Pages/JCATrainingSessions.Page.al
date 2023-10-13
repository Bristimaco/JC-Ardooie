page 50110 "JCA Training Sessions"
{
    Caption = 'Training Sessions';
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "JCA Training Session";
    DelayedInsert = true;
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(TrainingSessions)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Training Group Code"; Rec."Training Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Training Group Description"; Rec."Training Group Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }      
                field(Status;Rec.Status)
                {
                    ApplicationArea =all;
                    ToolTip = ' ',Locked = true;
                }      
            }
        }
    }
}
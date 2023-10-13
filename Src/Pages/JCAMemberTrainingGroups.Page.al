page 50109 "JCA Member Training Groups"
{
    Caption = 'Training Group Members';
    PageType = ListPart;
    SourceTable = "JCA Training Group Member";
    UsageCategory = None;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Member)
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
                }
            }
        }
    }
}
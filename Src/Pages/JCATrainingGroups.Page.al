page 50107 "JCA Training Groups"
{
    Caption = 'Training Groups';
    PageType = List;
    UsageCategory = Administration;
    DelayedInsert = true;
    SourceTable = "JCA Training Group";

    layout
    {
        area(Content)
        {
            repeater(TraingGroups)
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
                field(members; Rec.members)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
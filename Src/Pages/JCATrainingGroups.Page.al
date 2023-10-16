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
                field("Open for Other Clubs"; Rec."Open for Other Clubs")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }

            part(TrainingGroupMembers; "JCA Training Group Members")
            {
                Caption = 'Members';
                ApplicationArea = all;
                SubPageLink = "Training Group Code" = field(Code);
                UpdatePropagation = Both;
            }
        }
    }
}
page 50105 "JCA Weight Groups"
{
    Caption = 'Weight Groups';
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "JCA Weight Group";
    DelayedInsert = true;
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(WeightGroup)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group"; Rec."Age Group")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Max. Weight"; Rec."Max. Weight")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
page 50130 "JCA Clubs"
{
    Caption = 'Clubs';
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "JCA Club";
    PageType = list;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Clubs)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Our Club"; Rec."Our Club")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
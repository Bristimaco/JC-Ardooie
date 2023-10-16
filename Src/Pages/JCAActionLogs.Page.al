page 50125 "JCA Action Logs"
{
    Caption = 'Action Logs';
    ApplicationArea = all;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "JCA Action Log";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(ActionLogs)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Application Action"; Rec."Application Action")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Logged by"; Rec."Logged by")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Logged on"; Rec."Logged on")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
            }
        }
    }
}
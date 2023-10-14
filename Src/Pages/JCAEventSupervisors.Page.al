page 50120 "JCA Event Supervisors"
{
    Caption = 'Event Supervisors';
    SourceTable = "JCA Event Supervisor";
    PageType = ListPart;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(EventSupervisors)
            {
                field("Member License ID"; Rec."Member License ID")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Member Full Name"; Rec."Member Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Invited; Rec.Invited)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
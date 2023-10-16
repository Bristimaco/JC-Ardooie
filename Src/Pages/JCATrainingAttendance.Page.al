page 50129 "JCA Training Attendance"
{
    Caption = 'Training Attendance';
    SourceTable = "JCA Tr. Session Participant";
    PageType = List;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(Attendees)
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
                field(Participation; Rec.Participation)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }                
            }
        }
    }
}
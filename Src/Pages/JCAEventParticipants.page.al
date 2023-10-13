page 50119 "JCA Event Participants"
{
    Caption = 'Event Participants';
    SourceTable = "JCA Event Participant";
    PageType = ListPart;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(EventParticipants)
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
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group Code"; Rec."Age Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group Description"; Rec."Age Group Description")
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
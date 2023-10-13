page 50112 "JCA Tr. Session Participants"
{
    Caption = 'Training Session Participants';
    UsageCategory = None;
    SourceTable = "JCA Tr. Session Participant";
    PageType = ListPart;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(TrainingSessionParticipants)
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.calcfields("Training Group Code");
    end;
}
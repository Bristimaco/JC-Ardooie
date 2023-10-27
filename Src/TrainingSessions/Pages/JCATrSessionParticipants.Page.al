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
                field(Participation; Rec.Participation)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
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
                field("Participant Type"; Rec."Participant Type")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                Field("Club Name"; Rec."Club Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field(Belt; Rec.Belt)
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
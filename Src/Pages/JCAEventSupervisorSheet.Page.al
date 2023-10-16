page 50127 "JCA Event Supervisor Sheet"
{
    Caption = 'Event Supervisor Sheet';
    SourceTable = "JCA Event Participant";
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(EventParticipants)
            {
                field("No-Show"; Rec."No-Show")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                Field("Member Full Name"; Rec."Member Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                Field(Result; Rec.Result)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;

                    trigger OnValidate()
                    begin
                        if xRec.Result <> rec.Result then
                            Rec.SendEventResultMail();
                    end;
                }
            }
        }
    }
}
page 50126 "JCA Today Cues"
{
    Caption = 'Today';
    SourceTable = "JCA Cue";
    PageType = CardPart;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(TodayCues)
            {
                ShowCaption = false;

                field("Training Sessions Today"; Rec."Training Sessions Today")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Events Today"; Rec."Events Today")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty() then begin
            Rec.init();
            Rec.insert();
        end;
        Rec.SetRange("Training Date Filter", Today());
        rec.SetRange("Event Date Filter", today());
    end;
}
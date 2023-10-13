page 50111 "JCA Training Session Cues"
{
    Caption = 'Training Sessions';
    SourceTable = "JCA Cue";
    PageType = CardPart;
    RefreshOnActivate = true;    

    layout
    {
        area(Content)
        {
            cuegroup(TrainingSessionCues)
            {
                ShowCaption = false;

                field("Open Training Sessions";Rec."Open Training Sessions")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Closed Training Sessions";Rec."Closed Training Sessions")
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
        Rec.SetFilter("Date Filter", '=%1&<%2', 0D, Today());
    end;
}
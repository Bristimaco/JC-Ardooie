page 50115 "JCA Event Cues"
{
    Caption = 'Events';
    SourceTable = "JCA Cue";
    RefreshOnActivate = true;
    PageType = CardPart;

    layout
    {
        area(Content)
        {
            cuegroup(Tournaments)
            {
                Caption = 'Tournaments';

                field("New Tournaments"; Rec."New Tournaments")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;                    
                }
            }

            cuegroup(Stages)
            {
                Caption = 'Stages';

                field("New Stages"; Rec."New Stages")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }

            cuegroup(Chiai)
            {
                field("New Chiai"; Rec."New Chiai")
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
    end;
}
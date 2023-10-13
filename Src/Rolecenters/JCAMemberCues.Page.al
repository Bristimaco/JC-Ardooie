page 50104 "JCA Member Cues"
{
    Caption = 'Members';
    SourceTable = "JCA Cue";
    PageType = CardPart;
    RefreshOnActivate = true;    

    layout
    {
        area(Content)
        {
            cuegroup(MembersCues)
            {
                ShowCaption = false;

                field(ActiveMembers; Rec."Active Members")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(InactiveMembers; Rec."Inactive Members")
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
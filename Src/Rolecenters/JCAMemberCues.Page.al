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
                field(Contacts; Rec.Contacts)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Open Membership Payment Req."; Rec."Open Membership Payment Req.")
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
        rec.setfilter("Membership Filter", '<>%1', '');
        rec.SetFilter("Membersh. Start Date Filter", '<=%1', Today());
        rec.SetFilter("Membersh. End Date Filter", '>=%1', Today());
    end;
}
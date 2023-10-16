page 50113 "JCA Training Session Card"
{
    Caption = 'Training Session Card';
    PageType = Card;
    SourceTable = "JCA Training Session";
    InsertAllowed = false;
    DeleteAllowed = true;
    DataCaptionExpression = format(Rec.Date) + ' - ' + Rec."Training Group Description";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(ID; Rec."No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Training Group Code"; Rec."Training Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Training Group Description"; Rec."Training Group Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Open for Other Clubs"; Rec."Open for Other Clubs")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Potential Participants"; Rec."Potential Participants")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Actual Participants"; Rec."Actual Participants")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }

            part(TrainingSessionParticipants; "JCA Tr. Session Participants")
            {
                Caption = 'Participants';
                ApplicationArea = all;
                SubPageLink = "Training Session No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(FetchPatricipants)
            {
                Caption = 'Fetch Participants';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.FetchParticipants();
                end;
            }
        }
    }
}
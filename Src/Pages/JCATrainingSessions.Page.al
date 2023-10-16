page 50110 "JCA Training Sessions"
{
    Caption = 'Training Sessions';
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "JCA Training Session";
    Editable = false;
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(TrainingSessions)
            {
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
                field(Status; Rec.Status)
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
        }
    }

    actions
    {
        area(Processing)
        {
            action(Card)
            {
                Caption = 'Card';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    rec.OpenCard();
                end;
            }

            action(New)
            {
                Caption = 'New';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    JCATrainingManagement: Codeunit "JCA Training Management";
                begin
                    clear(JCATrainingManagement);
                    JCATrainingManagement.CreateNewTrainingSession(true);
                end;
            }
            action(OpenAttendanceSheet)
            {
                Caption = 'Attendance Sheet';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = EmployeeAgreement;
                RunObject = page "JCA Training Attendance";
                RunPageLink = "Training Session No." = field("No.");
            }
        }
    }
}
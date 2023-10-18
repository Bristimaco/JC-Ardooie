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
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }

                group(Invoicing)
                {
                    Caption = 'Invoicing';

                    field("Invoice To Customer No."; Rec."Invoice To Customer No.")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Invoice To Customer Name"; Rec."Invoice To Customer Name")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }
            }

            part(TrainingSessionTrainers; "JCA Tr. Session Participants")
            {
                Caption = 'Trainers';
                ApplicationArea = all;
                SubPageLink = "Training Session No." = field("No."), "Participant Type" = const(Trainer);
                UpdatePropagation = Both;
            }
            part(TrainingSessionParticipants; "JCA Tr. Session Participants")
            {
                Caption = 'Participants';
                ApplicationArea = all;
                SubPageLink = "Training Session No." = field("No."), "Participant Type" = const(Judoka);
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
                Image = GetLines;

                trigger OnAction()
                begin
                    Rec.FetchParticipants();
                end;
            }
            action(FetchSupervisors)
            {
                Caption = 'Fetch Supervisors';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = GetLines;

                trigger OnAction()
                begin
                    Rec.FetchSupervisors();
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
            action(Close)
            {
                Caption = 'Close Session';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Promoted = true;
                PromotedCategory = Process;
                Image = Close;

                trigger OnAction()
                begin
                    rec.testfield(status, rec.status::Open);
                    rec.validate(status, rec.Status::Closed);
                    rec.modify(true);
                end;
            }
            action(ReOpen)
            {
                Caption = 'Reopen Session';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Promoted = true;
                PromotedCategory = Process;
                Image = Open;

                trigger OnAction()
                begin
                    rec.testfield(status, rec.status::Closed);
                    rec.validate(status, rec.Status::Open);
                    rec.modify(true);
                end;
            }
        }
        area(Reporting)
        {
            action(InvoiceTrainingSession)
            {
                Caption = 'Create Invoice';
                Image = Document;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Ellipsis = true;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    Rec.InvoiceTrainingSession();
                end;
            }
            action(OpenInvoice)
            {
                Caption = 'Open Invoice';
                Image = Document;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Ellipsis = true;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    Rec.OpenInvoice();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CheckEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        CheckEditable();
    end;

    local procedure CheckEditable();
    begin
        TrainingSessionEditable := rec.status = rec.status::Open;
        CurrPage.Editable := TrainingSessionEditable;
    end;

    var
        TrainingSessionEditable: Boolean;
}
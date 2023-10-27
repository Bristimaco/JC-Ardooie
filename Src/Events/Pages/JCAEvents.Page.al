page 50116 "JCA Events"
{
    Caption = 'Events';
    SourceTable = "JCA Event";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Events)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Registration Deadline"; Rec."Registration Deadline")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Potential Participants"; Rec."Potential Participants")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Invited Participants"; Rec."Invited Participants")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Registered Participants"; Rec."Registered Participants")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
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
                    JCAEventManagement: Codeunit "JCA Event Management";
                begin
                    clear(JCAEventManagement);
                    JCAEventManagement.CreateNewEvent(true);
                end;
            }
            action(SupervisorSheet)
            {
                Caption = 'Supervisor Sheet';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    rec.OpenSupervisorSheet();
                end;
            }
        }
        area(Reporting)
        {
            action(EventReport)
            {
                Caption = 'Event Report';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Ellipsis = true;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                var
                    JCAEvent: record "JCA Event";
                    JCAEventReport: report "JCA Event Report";
                begin
                    JCAEvent.reset();
                    JCAEvent.setrange("No.", rec."No.");
                    clear(JCAEventReport);
                    JCAEventReport.SetTableView(JCAEvent);
                    JCAEventReport.run();
                end;
            }
            action(EventRefunds)
            {
                Caption = 'Event Refunds';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Ellipsis = true;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                var
                    JCAEventRefunds: report "JCA Event Refunds";
                begin
                    clear(JCAEventRefunds);
                    JCAEventRefunds.Run();
                end;
            }
        }
    }
}
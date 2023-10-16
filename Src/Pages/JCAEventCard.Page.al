page 50117 "JCA Event Card"
{
    Caption = 'Event Card';
    SourceTable = "JCA Event";
    PageType = Card;
    UsageCategory = None;
    DataCaptionExpression = format(Rec.Type) + ' - ' + rec.Description;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Registration Deadline"; Rec."Registration Deadline")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Send Result Mails"; Rec."Send Result Mails")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }

                group(Progress)
                {
                    Caption = 'Progress';

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

            group(EventSpecifics)
            {
                Caption = 'Specifics';

                part(AgeGroups; "JCA Event Age Groups")
                {
                    Caption = 'Event Age Groups';
                    SubPageLink = "Event No." = field("No."), "Country Code" = field("Country Code");
                    ApplicationArea = all;
                    UpdatePropagation = Both;
                }

                part(EventDocuments; "JCA Event Documents")
                {
                    Caption = 'Documents';
                    ApplicationArea = all;
                    SubPageLink = "Event No." = field("No.");
                }
            }

            part(EventSupervisors; "JCA Event Supervisors")
            {
                Caption = 'Event Supervisors';
                SubPageLink = "Event No." = field("No.");
                ApplicationArea = all;
                UpdatePropagation = Both;
            }

            Part(Participants; "JCA Event Participants")
            {
                Caption = 'Event Participants';
                SubPageLink = "Event No." = field("No.");
                ApplicationArea = all;
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
                Image = GetEntries;

                trigger OnAction()
                begin
                    Rec.FetchParticipants();
                    CurrPage.Update();
                end;
            }
            action(SendInvitations)
            {
                Caption = 'Send Invitations';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = SendMail;

                trigger OnAction()
                begin
                    Rec.SendInvitations();
                    CurrPage.Update();
                end;
            }
        }
    }
}
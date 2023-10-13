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

            part(AgeGroups; "JCA Event Age Groups")
            {
                Caption = 'Event Age Groups';
                SubPageLink = "Event ID" = field(ID);
                ApplicationArea = all;
                UpdatePropagation = both;
            }

            Part(Participants; "JCA Event Participants")
            {
                Caption = 'Event Participants';
                SubPageLink = "Event ID" = field(ID);
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

                trigger OnAction()
                begin
                    Rec.FetchParticipants();
                    CurrPage.Update();
                end;
            }
        }
    }
}
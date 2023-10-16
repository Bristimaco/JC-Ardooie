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
        }
    }
}
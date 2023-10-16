page 50119 "JCA Event Participants"
{
    Caption = 'Event Participants';
    SourceTable = "JCA Event Participant";
    PageType = ListPart;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(EventParticipants)
            {
                field("Member License ID"; Rec."Member License ID")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Member Full Name"; Rec."Member Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group Code"; Rec."Age Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group Description"; Rec."Age Group Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Invited; Rec.Invited)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Applied for Registration"; Rec."Applied for Registration")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Registration Confirmed"; Rec."Registration Confirmed")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("No-Show"; Rec."No-Show")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    Editable = false;
                }
                Field(Result; Rec.Result)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    Editable = false;
                }
                field("Supervisor Comment";Rec."Supervisor Comment")
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
            action(SendInvitation)
            {
                Caption = 'Send Invitation';
                Image = SendMail;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    Rec.SendInvitationMail();
                end;
            }
            action(ConfirmRegistration)
            {
                Caption = 'Confirm Registration';
                Image = SendMail;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    Rec.ConfirmRegistration();
                end;
            }
            action(ConfirmUnRegistration)
            {
                Caption = 'Confirm Unregistration';
                Image = SendMail;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    Rec.ConfirmUnRegistration();
                end;
            }
        }
    }
}
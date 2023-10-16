page 50120 "JCA Event Supervisors"
{
    Caption = 'Event Supervisors';
    SourceTable = "JCA Event Supervisor";
    PageType = ListPart;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(EventSupervisors)
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
page 50134 "JCA Memberships"
{
    Caption = 'Memberships';
    SourceTable = "JCA Membership";
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Administration;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Memberships)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Membership Fee"; Rec."Membership Fee")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Membership Period"; Rec."Membership Period")
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
            action(CreateMembershipRequests)
            {
                Caption = 'Create Membership Requests';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = SendApprovalRequest;

                trigger OnAction()
                var
                    JCAMemberManagement: Codeunit "JCA Member Management";
                begin
                    Clear(JCAMemberManagement);
                    JCAMemberManagement.CreateMembershipRenewals();
                end;
            }
        }
    }
}
page 50106 "JCA Age Groups"
{
    Caption = 'Age Groups';
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "JCA Age Group";

    layout
    {
        area(Content)
        {
            repeater(AgeGroups)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Max Age"; Rec."Max Age")
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
            action(UpdateMemberAgeGroups)
            {
                Caption = 'Update Member Age Groups';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                var
                    JCADailyUpdates: Codeunit "JCA Daily Updates";
                begin
                    Clear(JCADailyUpdates);
                    JCADailyUpdates.UpdateAgeGroupsOnMembers();
                    Message('Member Age Groups have been Updated.')
                end;
            }
        }
    }
}
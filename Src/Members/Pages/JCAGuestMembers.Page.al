page 50131 "JCA Guest Members"
{
    Caption = 'Guest Members';
    SourceTable = "JCA Guest Member";
    ApplicationArea = all;
    UsageCategory = Lists;
    DelayedInsert = true;
    PageType = List;
    CardPageId = "JCA Guest Member Card";

    layout
    {
        area(Content)
        {
            repeater(GuestMembers)
            {
                field("License ID"; Rec."License ID")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Belt; Rec.Belt)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }

            part(TrainingGroups; "JCA Guest Member Tr. Groups")
            {
                Caption = 'Training Groups';
                ApplicationArea = all;
                SubPageLink = "Guest Member License ID" = field("License ID");
                UpdatePropagation = Both;
            }
        }
    }
}
page 50141 "JCA Mail Message Templates"
{
    Caption = 'Mail Message Templates';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "JCA Mail Message Template";
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(MailMessageTemplates)
            {
                field("Mail Message Type"; Rec."Mail Message Type")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(HasTemplate; Rec."Mail Template Data".HasValue())
                {
                    Caption = 'Has Template';
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
            action(EditTemplate)
            {
                Caption = 'Edit Template';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Ellipsis = true;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Mail Message Templ. Card";
                RunPageLink = "Mail Message Type" = field("Mail Message Type");
            }
        }
    }
}
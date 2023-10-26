page 50144 "JCA HTML Gen. CSS Templates"
{
    Caption = 'HTML Gen. CSS Templates';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "JCA HTML Gen. CSS Template";
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(MailMessageTemplates)
            {
                field("HTML Gen. CSS Type"; Rec."HTML Gen. CSS Type")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(HasTemplate; Rec."CSS Template Data".HasValue())
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

                trigger OnAction()
                begin
                    Rec.OpenTemplateEditor();
                end;
            }
        }
    }
}
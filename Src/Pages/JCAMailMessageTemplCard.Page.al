page 50142 "JCA Mail Message Templ. Card"
{
    Caption = 'Mail Message Templ. Card';
    SourceTable = "JCA Mail Message Template";
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Template)
            {
                Field("Mail Message Type"; Rec."Mail Message Type")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    Editable = false;
                }
                field(TemplateData; TemplateData)
                {
                    Caption = 'Template Data';
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Load)
            {
                Caption = 'Load';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    rec.ReadTemplateData(TemplateData);
                end;
            }
            action(Save)
            {
                Caption = 'Save';
                Image = Save;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    rec.WriteTemplateData(TemplateData);
                end;
            }
        }
    }

    var
        TemplateData: Text;
}
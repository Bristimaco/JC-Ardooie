page 50148 "JCA Gr. Ev. Res. Mail Editor"
{
    Caption = 'Grouped Event Result Mail Editor';
    SourceTable = "JCA Mail Message Template";
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = none;

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
                group(ExampleData)
                {
                    Caption = 'Example Data';

                    field("Event No."; Rec."Event No.")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }
            }
            group(TemplateEditor)
            {
                Caption = 'Editor';

                usercontrol(Editor; TinyMCEEditor)
                {
                    ApplicationArea = All;

                    trigger ControlAddInReady(IsReady: Boolean)

                    begin
                        IsEditorReady := IsReady;
                        CurrPage.Editor.InitContent(true, true);
                    end;

                    trigger DocumentReady(IsReady: Boolean)
                    begin
                        FillEditor();
                    end;

                    trigger ContentText(Contents: Text; IsText: Boolean)
                    var
                        TypeHelper: codeunit "Type Helper";
                    begin
                        TemplateData := TypeHelper.HtmlDecode(Contents);
                        Rec.WriteTemplateData(TemplateData);
                        UpdateExample();
                    end;

                    trigger ContentHasSaved()
                    begin
                        CurrPage.Editor.GetContent();
                    end;
                }

                usercontrol(Example; TinyMCEEditor)
                {
                    ApplicationArea = All;

                    trigger ControlAddInReady(IsReady: Boolean)
                    begin
                        IsExampleReady := IsReady;
                        CurrPage.Example.InitContent(false, true);
                        UpdateExample();
                    end;

                    trigger DocumentReady(IsReady: Boolean)
                    begin
                        CurrPage.Example.SetContent(ExampleHTML);
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RefreshExample)
            {
                Caption = 'Refresh Example';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Visible = false;

                trigger OnAction()
                begin
                    UpdateExample();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateExampleData();
    end;

    local procedure FillEditor()
    var
        TypeHelper: codeunit "Type Helper";
    begin
        if not IsEditorReady then
            exit;
        rec.ReadTemplateData(TemplateData);
        CurrPage.Editor.SetContent(TypeHelper.HtmlEncode(TemplateData));
    end;

    local procedure UpdateExample()
    var
        TypeHelper: codeunit "Type Helper";
    begin
        if not IsExampleReady then
            exit;
        UpdateExampleData();
        ExampleHtml := TypeHelper.HtmlDecode(EmailContent);
        CurrPage.Example.SetContent(ExampleHtml);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if IsEditorReady then
            CurrPage.Editor.SetDispose();
    end;

    local procedure UpdateExampleData()
    var
        tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary;
        JCAEventMailing: Interface "JCA Event Mailing";
    begin
        JCAEventMailing := enum::"JCA Mail Message Type"::"Grouped Event Result";
        tempJCAMailMessageTemplate.reset();
        tempJCAMailMessageTemplate.init();
        tempJCAMailMessageTemplate."Mail Message Type" := enum::"JCA Mail Message Type"::"Grouped Event Result";
        tempJCAMailMessageTemplate."Event No." := Rec."Event No.";
        EmailContent := JCAEventMailing.ReturnMailContent(tempJCAMailMessageTemplate);
    end;

    var
        IsEditorReady: Boolean;
        IsExampleReady: Boolean;
        TemplateData: Text;
        EmailContent: Text;
        ExampleHTML: Text;
}
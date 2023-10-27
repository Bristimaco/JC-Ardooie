page 50143 "JCA Event Inv. Mail Editor"
{
    Caption = 'Event Invitation Mail Editor';
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
                group(ExampleData)
                {
                    Caption = 'Example Data';

                    field("Member License ID"; Rec."Member License ID")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;

                        trigger OnValidate()
                        begin
                            UpdateExampleData();
                            UpdateExample();
                        end;
                    }
                    Field("Event No."; Rec."Event No.")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;

                        trigger OnValidate()
                        begin
                            UpdateExampleData();
                            UpdateExample();
                        end;
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
                        UpdateExample();
                    end;
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
                    FillEditor();
                    UpdateExample();
                end;
            }
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
        CurrPage.Editor.InitContent(true, true);
        CurrPage.Editor.SetContent(TypeHelper.HtmlEncode(TemplateData));
        CurrPage.Editor.SetContentType(true, true);
    end;

    local procedure UpdateExample()
    var
        TypeHelper: codeunit "Type Helper";
        ExampleHtml: text;
    begin
        if not IsExampleReady then
            exit;
        UpdateExampleData();
        ExampleHtml := TypeHelper.HtmlDecode(EmailContent);
        CurrPage.Example.InitContent(false, true);
        CurrPage.Example.SetContent(ExampleHtml);
        CurrPage.Example.SetContentType(false, true);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if IsEditorReady then
            CurrPage.Editor.SetDispose();
    end;

    local procedure UpdateExampleData()
    var
        tempJCAMailMessaegTemplate: record "JCA Mail Message Template" temporary;
        JCAEventMailing: Interface JCAEventMailing;
    begin
        JCAEventMailing := enum::"JCA Mail Message Type"::Invitation;
        tempJCAMailMessaegTemplate.reset();
        tempJCAMailMessaegTemplate.init();
        tempJCAMailMessaegTemplate."Mail Message Type" := enum::"JCA Mail Message Type"::Invitation;
        tempJCAMailMessaegTemplate."Member License ID" := rec."Member License ID";
        tempJCAMailMessaegTemplate."Event No." := rec."Event No.";
        EmailContent := JCAEventMailing.ReturnMailContent(tempJCAMailMessaegTemplate);
    end;

    var
        IsEditorReady: Boolean;
        IsExampleReady: Boolean;
        TemplateData: Text;
        EmailContent: Text;
}
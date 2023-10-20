page 50142 "JCA Event Result Mail Editor"
{
    Caption = 'Event Result Mail Editor';
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
                        end;
                    }
                    field("Event Result"; Rec."Event Result")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;

                        trigger OnValidate()
                        begin
                            UpdateExampleData();
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

                        // if IsEditorReady then
                        //     FillAddIns();
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
                    end;
                }
            }
        }

        // area(FactBoxes)
        // {
        //     part(MailTemplateExample; "JCA Mail Mess. Templ. Example")
        //     {
        //         ApplicationArea = all;
        //         SubPageLink = "Mail Message Type" = field("Mail Message Type");
        //     }
        // }
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

                trigger OnAction()
                begin
                    UpdateExample();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateExampleData();
    end;

    local procedure FillEditor()
    var
        TypeHelper: codeunit "Type Helper";
    begin
        if not IsEditorReady then
            exit;

        CurrPage.Editor.InitContent(true, true);
        CurrPage.Editor.SetContent(TypeHelper.HtmlEncode(TemplateData));
        CurrPage.Editor.SetContentType(true, true);
    end;

    local procedure UpdateExample()
    var
        TypeHelper: codeunit "Type Helper";
        ExampleHTML: Text;
    begin
        if not IsExampleReady then
            exit;
        ExampleHTML := TemplateData;
        ExampleHTML := TypeHelper.HtmlDecode(ExampleHTML);
        ExampleHTML := StrSubstNo(ExampleHTML, ResultCardLogo, MemberPicture, ResultImage, MemberName, ResultText);
        //CurrPage.MailTemplateExample.Page.FillAddIn(ExampleHTML);
        CurrPage.Example.InitContent(false, true);
        CurrPage.Example.SetContent(ExampleHTML);
        CurrPage.Example.SetContentType(false, true);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if IsEditorReady then
            CurrPage.Editor.SetDispose();
    end;

    local procedure UpdateExampleData()
    var
        JCAMember: record "JCA Member";
        JCASetup: Record "JCA Setup";
        JCAResultImage: Record "JCA Result Image";
    begin
        MemberPicture := '';
        JCAMember.Reset();
        if JCAMember.get(rec."Member License ID") then begin
            MemberPicture := JCAMember.GetPicture();
            MemberName := JCAMember."Full Name";
        end;

        ResultCardLogo := '';
        JCASetup.Reset();
        JCASetup.get();
        ResultCardLogo := JCASetup.GetResultCardLogo();

        ResultImage := '';
        JCAResultImage.Reset();
        if JCAResultImage.get(rec."Event Result") then begin
            ResultImage := JCAResultImage.GetImage();
            ResultText := UpperCase(format(JCAResultImage.Result));
        end;
    end;



    var
        IsEditorReady: Boolean;
        IsExampleReady: Boolean;
        TemplateData: Text;
        ResultCardLogo: Text;
        MemberPicture: Text;
        ResultImage: Text;
        MemberName: Text;
        ResultText: Text;
}
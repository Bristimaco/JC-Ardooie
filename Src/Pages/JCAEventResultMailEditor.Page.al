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
            group(Editor)
            {
                Caption = 'Editor';

                usercontrol(TinyMCEEditor; TinyMCEEditor)
                {
                    ApplicationArea = All;

                    trigger ControlAddInReady(IsReady: Boolean)

                    begin
                        IsControlAddInReady := IsReady;
                        if (not IsControlAddInReady) then
                            exit;

                        CurrPage.TinyMCEEditor.InitContent(true, true);
                        rec.ReadTemplateData(TemplateData);
                        CurrPage.TinyMCEEditor.SetContent(TemplateData);
                    end;

                    trigger DocumentReady(IsReady: Boolean)
                    begin
                        IsDocumentReady := IsReady;
                    end;


                    trigger ContentText(Contents: Text; IsText: Boolean)
                    var
                        TypeHelper: codeunit "Type Helper";
                    begin
                        Message(Contents);
                        TemplateData := TypeHelper.HtmlDecode(Contents);
                        Rec.WriteTemplateData(TemplateData);
                        UpdateExample();
                    end;
                }
            }
        }

        area(FactBoxes)
        {
            part(MailTemplateExample; "JCA Mail Mess. Templ. Example")
            {
                ApplicationArea = all;
                SubPageLink = "Mail Message Type" = field("Mail Message Type");
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
                    FillAddIns();
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
                    CurrPage.TinyMCEEditor.GetContent()
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FillAddIns();
    end;

    local procedure FillAddIns()
    var
        TypeHelper: codeunit "Type Helper";
    begin
        rec.ReadTemplateData(TemplateData);
        CurrPage.TinyMCEEditor.SetContent(TypeHelper.HtmlEncode(TemplateData));
        CurrPage.TinyMCEEditor.SetContentType(true, true);
        UpdateExampleData();
    end;

    local procedure UpdateExample()
    var
        ExampleHTML: Text;
    begin
        ExampleHTML := StrSubstNo(TemplateData, ResultCardLogo, MemberPicture, ResultImage, MemberName, ResultText);
        CurrPage.MailTemplateExample.Page.FillAddIn(ExampleHTML);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if IsControlAddInReady AND IsDocumentReady then
            CurrPage.TinyMCEEditor.SetDispose();
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
        UpdateExample();
    end;



    var
        IsDocumentReady: Boolean;
        IsControlAddInReady: Boolean;
        TemplateData: Text;
        ResultCardLogo: Text;
        MemberPicture: Text;
        ResultImage: Text;
        MemberName: Text;
        ResultText: Text;
}
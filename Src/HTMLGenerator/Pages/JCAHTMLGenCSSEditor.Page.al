page 50145 "JCA HTML Gen. CSS Editor"
{
    Caption = 'HTML Gen. CSS Template Editor';
    SourceTable = "JCA HTML Gen. CSS Template";
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
                field("HTML Gen. CSS Type"; Rec."HTML Gen. CSS Type")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    Editable = false;
                }
                group(ExampleData)
                {
                    Caption = 'Example Data';

                    field("Start Date"; Rec."Start Date")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("End Date"; Rec."End Date")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
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
                        FillEditor();
                    end;

                    trigger ContentText(Contents: Text; IsText: Boolean)
                    var
                        TypeHelper: codeunit "Type Helper";
                    begin
                        TemplateData := TypeHelper.HtmlDecode(Contents);
                        Rec.WriteTemplateData(TemplateData);
                    end;

                    trigger ContentHasSaved()
                    begin
                        CurrPage.Editor.GetContent();
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
                end;
            }

            action(GenerateExample)
            {
                Caption = 'Generate Example';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = ' ', Locked = true;
                Image = Web;

                trigger OnAction()
                var
                    JCAEvent: record "JCA Event";
                    DateFilters: record Date;
                    TempBlob: codeunit "Temp Blob";
                    JCAHTMLGenerator: Interface "JCA HTML Generator";
                    HTMLContent: Text;
                    FileName: Text;
                    InStream: InStream;
                    OutStream: OutStream;
                begin
                    JCAHTMLGenerator := Rec."HTML Gen. CSS Type";
                    case Rec."HTML Gen. CSS Type" of
                        enum::"JCA HTML Gen. CSS Type"::Calendar:
                            begin
                                rec.TestField("Start Date");
                                rec.TestField("End Date");
                                DateFilters.Reset();
                                DateFilters.setrange("Period Type", DateFilters."Period Type"::Date);
                                DateFilters.setrange("Period Start", rec."Start Date", rec."End Date");
                                HTMLContent := JCAHTMLGenerator.GenerateHTML(DateFilters);
                                FileName := format(Rec."HTML Gen. CSS Type") + '.html';
                            end;
                        enum::"JCA HTML Gen. CSS Type"::"Event Result":
                            begin
                                rec.TestField("Event No.");
                                JCAEvent.Reset();
                                JCAEvent.get(rec."Event No.");
                                HTMLContent := JCAHTMLGenerator.GenerateHTML(JCAEvent);
                                FileName := format(rec."HTML Gen. CSS Type") + '.html';
                            end;
                    end;
                    TempBlob.CreateOutStream(OutStream);
                    OutStream.WriteText(HTMLContent);
                    TempBlob.CreateInStream(InStream);
                    DownloadFromStream(InStream, '', '', '', FileName);
                end;
            }
        }
    }

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

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if IsEditorReady then
            CurrPage.Editor.SetDispose();
    end;

    var
        IsEditorReady: Boolean;
        TemplateData: Text;
}
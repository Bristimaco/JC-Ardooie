page 50143 "JCA Mail Mess. Templ. Example"
{
    Caption = 'Example';
    ApplicationArea = all;
    SourceTable = "JCA Mail Message Template";
    Editable = false;
    PageType = CardPart;

    layout
    {
        area(Content)
        {
            group(Example)
            {
                ShowCaption = false;

                usercontrol(MailTemlateData; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
                {
                    ApplicationArea = All;

                    trigger ControlAddInReady(callbackUrl: Text)
                    begin
                        IsReady := true;
                        CurrPage.MailTemlateData.SetContent(ExampleData);
                    end;
                }
            }

            group(PageSizer)
            {
                ShowCaption = false;
                Visible = ShowPageSizer;

                field("Mail Message Type"; Rec."Mail Message Type")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Mail Template Data"; Rec."Mail Template Data")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(TemplateHasValue; Rec."Mail Template Data".HasValue)
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        ShowPageSizer := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ShowPageSizer := false;
    end;

    procedure FillAddIn(ExampleContent: Text)
    var
        TypeHelper: codeunit "Type Helper";
    begin
        ExampleData := TypeHelper.HtmlDecode(ExampleContent);
        if IsReady then begin
            CurrPage.MailTemlateData.SetContent(ExampleData);
            CurrPage.update();
        end;
    end;

    var
        IsReady: Boolean;
        ShowPageSizer: Boolean;
        ExampleData: Text;
}
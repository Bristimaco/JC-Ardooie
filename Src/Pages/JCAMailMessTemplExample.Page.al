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
                    end;
                }
                field(Delimiter; '')
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }

    procedure FillAddIn(ExampleContent: Text)
    var
        TypeHelper: codeunit "Type Helper";
        HTMLContent: Text;
    begin
        if IsReady then begin
            HTMLContent := TypeHelper.HtmlDecode(ExampleContent);
            CurrPage.MailTemlateData.SetContent(ExampleContent);
        end;
    end;

    var
        IsReady: Boolean;
}
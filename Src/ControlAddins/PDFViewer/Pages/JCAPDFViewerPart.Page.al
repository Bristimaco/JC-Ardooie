page 50157 "JCA PDF Viewer Part"
{
    PageType = CardPart;
    Caption = 'PDF Viewer';
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            usercontrol(PDFViewer; "JCA PDF Viewer")
            {
                ApplicationArea = All;
                trigger OnControlAddInReady()
                begin
                    InitializePDFViewer();
                end;

                trigger OnPdfViewerReady()
                begin
                    ControlIsReady := true;
                    ShowData();
                end;
            }
        }
    }

    local procedure InitializePDFViewer()
    var
        JCAPDFViewerSetup: Record "JCA PDF Viewer Setup";
    begin
        JCAPDFViewerSetup.Reset();
        JCAPDFViewerSetup.get();
        JCAPDFViewerSetup.testfield("PDF Viewer URL");
        CurrPage.PDFViewer.InitializeControl(JCAPDFViewerSetup."PDF Viewer URL");
    end;

    local procedure ShowData()
    begin
        if not ControlIsReady then
            exit;

        if not Data.Contains('content') then
            exit;

        CurrPage.PDFViewer.LoadDocument(Data);

        Clear(Data);
    end;

    procedure LoadPdfViaUrl(Url: Text)
    begin
        Clear(Data);
        Data.Add('type', 'url');
        Data.Add('content', Url);
        ShowData();
    end;

    procedure LoadPdfFromBase64(Base64Data: Text)
    begin
        Clear(Data);
        Data.Add('type', 'base64');
        Data.Add('content', Base64Data);
        ShowData();
    end;

    var
        ControlIsReady: Boolean;
        Data: JsonObject;
}
page 50156 "JCA PDF Viewer"
{
    Caption = 'PDF Viewer';
    PageType = ListPlus;
    SourceTable = "PDF Viewer Buffer";
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
        JCAPDFViewerSetup.TestField("PDF Viewer URL");
        CurrPage.PDFViewer.InitializeControl(JCAPDFViewerSetup."PDF Viewer URL");
    end;

    local procedure ShowData()
    var
        JCAGetPDFData: codeunit "JCA Get PDF Data";
    begin
        CurrPage.PDFViewer.LoadDocument(JCAGetPDFData.GetData(Rec));
    end;
}
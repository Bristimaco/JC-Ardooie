codeunit 50119 "JCA Open PDF Viewer"
{
    procedure OpenPdfViewer(RecordVariant: Variant; FieldNo: Integer; Popup: Boolean)
    var
        PDFViewerBuffer: Record "PDF Viewer Buffer";
    begin
        SetPDFViewerBufferFilters(RecordVariant, FieldNo, PDFViewerBuffer);
        if Popup then
            OpenPopupPage(PDFViewerBuffer)
        else
            OpenPage(PDFViewerBuffer);
    end;

    local procedure OpenPage(var PDFViewerBuffer: Record "PDF Viewer Buffer")
    var
        JCAPDFViewer: Page "JCA PDF Viewer";
    begin
        JCAPDFViewer.SetTableView(PDFViewerBuffer);
        JCAPDFViewer.Run();
    end;

    local procedure OpenPopupPage(var PDFViewerBuffer: Record "PDF Viewer Buffer")
    var
        Url: Text;
    begin
        Url := GetUrl(CurrentClientType, CompanyName, ObjectType::Page, Page::"JCA PDF Viewer", PDFViewerBuffer, true);
        Url := Url + '&showheader=0&target="_blank"';
        Hyperlink(Url);
    end;

    local procedure SetPDFViewerBufferFilters(RecordVariant: Variant; FieldNo: Integer; var PDFViewerBuffer: Record "PDF Viewer Buffer")
    var
        RecordRef: RecordRef;
    begin
        RecordRef.GetTable(RecordVariant);
        PDFViewerBuffer.Reset();
        PDFViewerBuffer.SetRange(SourceTableId, RecordRef.Number);
        PDFViewerBuffer.SetRange(SourceId, RecordRef.Field(RecordRef.SystemIdNo).Value);
        PDFViewerBuffer.SetRange(FieldId, FieldNo);
    end;

}
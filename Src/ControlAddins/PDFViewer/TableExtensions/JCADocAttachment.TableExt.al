tableextension 50103 "JCA Doc. Attachment" extends "Document Attachment"
{
    procedure ViewAttachment(Popup: Boolean)
    begin
        if ID = 0 then
            exit;

        case Rec."File Type" of
            Rec."File Type"::PDF:
                ViewInPdfViewer(Popup);
        end
    end;

    local procedure ViewInPdfViewer(Popup: Boolean)
    var
        JCAOpenPDFViewer: Codeunit "JCA Open PDF Viewer";
    begin
        JCAOpenPDFViewer.OpenPdfViewer(Rec, Rec.FieldNo("Document Reference ID"), Popup);
    end;

}
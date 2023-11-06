controladdin "JCA PDF Viewer"
{
    StartupScript = 'src/ControlAddins/PDFViewer/AddIn/Scripts/startup.js';
    Scripts = 'src/ControlAddins/PDFViewer/AddIn/Scripts/script.js';

    HorizontalStretch = true;
    HorizontalShrink = true;
    MinimumWidth = 250;

    event OnControlAddInReady();
    event OnPdfViewerReady();
    procedure InitializeControl(url: Text);
    procedure LoadDocument(data: JsonObject);
}
page 50155 "JCA PDF Viewer Setup"
{
    Caption = 'PDF Viewer Setup';
    ApplicationArea = all;
    UsageCategory = Administration;
    SourceTable = "JCA PDF Viewer Setup";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("PDF Viewer URL"; Rec."PDF Viewer URL")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not Rec.findfirst() then begin
            Rec.init();
            Rec.validate("PDF Viewer URL", PDFViewerUrlTxt);
            Rec.insert(true);
        end;
    end;

    var
        PDFViewerUrlTxt: Label 'https://bcpdfviewer.z6.web.core.windows.net/web/viewer.html?file=', Locked = true;
}
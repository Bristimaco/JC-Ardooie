page 50137 "JCA Result Image Factbox"
{
    Caption = 'Result Image Factbox';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "JCA Result Image";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            Field("Result Image"; Rec."Result Image")
            {
                ApplicationArea = all;
                ShowCaption = false;
                ToolTip = ' ', Locked = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(UploadPicture)
            {
                ApplicationArea = All;
                Caption = 'Upload';
                Image = Import;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    UploadNewPicture();
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    DeleteResultImage();
                end;
            }
        }
    }

    local procedure UploadNewPicture()
    var
        InStream: InStream;
    begin
        UploadIntoStream('Afbeeldingsbestanden (*.bmp, *.jpg)|*.bmp;*.jpg|Alle bestanden (*.*)|*.*', InStream);
        Rec."Result Image".ImportStream(InStream, format(Rec.Result), MimeTypeTok);
        Rec.Modify(true);
    end;

    procedure DeleteResultImage()
    begin
        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec."Result Image");
        Rec.Modify(true);
    end;

    var
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        DeleteExportEnabled: Boolean;
        MimeTypeTok: Label 'image/jpeg', Locked = true;
}


page 50123 "JCA Member Factbox"
{
    Caption = 'Member Factbox';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "JCA Member";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = Invoicing, Basic, Suite;
                ShowCaption = false;
                ToolTip = ' ', Locked = true;
            }

            group(Medals)
            {
                Caption = 'Medals';

                field("Gold Medals"; Rec."Gold Medals")
                {
                    Caption = 'Gold';
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;

                    trigger OnDrillDown()
                    begin
                        Rec.OpenEventsWithMedal(enum::"JCA Event Result"::Gold);
                    end;
                }
                field("Silver Medals"; Rec."Silver Medals")
                {
                    Caption = 'Silver';
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;

                    trigger OnDrillDown()
                    begin
                        Rec.OpenEventsWithMedal(enum::"JCA Event Result"::Silver);
                    end;
                }
                field("Bronze Medals"; Rec."Bronze Medals")
                {
                    Caption = 'Bronze';
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;

                    trigger OnDrillDown()
                    begin
                        Rec.OpenEventsWithMedal(enum::"JCA Event Result"::Bronze);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                ToolTip = ' ', Locked = true;
                Visible = CameraAvailable AND (HideActions = FALSE);

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    DeleteItemPicture();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    procedure TakeNewPicture()
    begin
        Rec.Find();
        Rec.TestField("License ID");
        Rec.TestField("Full Name");
        DoTakeNewPicture()
    end;

    local procedure DoTakeNewPicture(): Boolean
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        if Rec.Picture.Count() > 0 then
            if not Confirm(OverrideImageQst) then
                exit(false);

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec.Picture);
            Rec.Picture.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true);
            exit(true);
        end;

        exit(false);
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Picture.Count <> 0;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        exit(Camera.IsAvailable());
    end;

    procedure SetHideActions()
    begin
        HideActions := true;
    end;

    procedure DeleteItemPicture()
    begin
        Rec.TestField("License ID");

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.Picture);
        Rec.Modify(true);
    end;

    var
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;
        MustSpecifyDescriptionErr: Label 'You must add a description to the item before you can import a picture.';
        MimeTypeTok: Label 'image/jpeg', Locked = true;
}


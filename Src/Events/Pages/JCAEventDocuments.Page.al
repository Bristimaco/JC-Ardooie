page 50124 "JCA Event Documents"
{
    Caption = 'Event Documents';
    UsageCategory = None;
    PageType = ListPart;
    SourceTable = "JCA Event Document";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(EventDocuments)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(DocumentContent; Rec."Document Content".HasValue())
                {
                    Caption = 'Has Content';
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    Editable = false;
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Add in Mails"; Rec."Add in Mails")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Folder; Rec.Folder)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UploadFile)
            {
                Caption = 'Upload File';
                Image = MoveUp;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    Rec.UploadDocument();
                end;
            }
            action(DownloadFile)
            {
                Caption = 'Download File';
                Image = MoveDown;
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnAction()
                begin
                    Rec.DownloadDocument();
                end;
            }
        }
    }
}
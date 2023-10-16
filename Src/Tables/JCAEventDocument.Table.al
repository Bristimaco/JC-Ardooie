table 50117 "JCA Event Document"
{
    Caption = 'Event Document';

    fields
    {
        field(1; "Event No."; code[20])
        {
            Caption = 'Event No.';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Event"."No.";
        }
        field(2; "Document No."; Integer)
        {
            Caption = 'Document No.';
            DataClassification = SystemMetadata;
        }
        field(3; Description; Text[150])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(4; "Document Content"; Blob)
        {
            Caption = 'Document Content';
            DataClassification = SystemMetadata;
        }
        field(5; "Add in Mails"; Boolean)
        {
            Caption = 'Add in Mails';
            DataClassification = SystemMetadata;
        }
        field(6; Extension; Text[10])
        {
            Caption = 'Extension';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Event No.", "Document No.")
        { }
    }

    procedure UploadDocument()
    var
        FileManagement: Codeunit "File Management";
        tempFileName: Text;
        InStream: InStream;
        OutStream: OutStream;
        UploadFileLbl: label 'Select a file to upload...';
    begin
        TestField(Description);
        UploadIntoStream(UploadFileLbl, '', 'All Files (*.*)|*.*', tempFileName, InStream);
        "Document Content".CreateOutStream(OutStream);
        CopyStream(OutStream, InStream);
        validate(Extension, FileManagement.GetExtension(tempFileName));
        Modify();
    end;

    procedure DownloadDocument()
    var
        tempFileName: Text;
        InStream: InStream;
        DownloadFileLbl: label 'Select a location...';
    begin
        CalcFields("Document Content");
        if not "Document Content".HasValue() then
            exit;
        "Document Content".CreateInStream(InStream);
        tempFileName := "Event No." + '.' + Extension;
        DownloadFromStream(InStream, DownloadFileLbl, '', '', tempFileName);
    end;
}
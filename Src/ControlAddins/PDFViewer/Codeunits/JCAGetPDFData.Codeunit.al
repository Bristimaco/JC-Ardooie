codeunit 50117 "JCA Get PDF Data"
{
    procedure GetData(var PDFViewerBuffer: Record "PDF Viewer Buffer") Data: JsonObject
    var
        Content, ContentType : Text;
    begin
        GetContent(PDFViewerBuffer, ContentType, Content);
        Data.Add('type', ContentType);
        Data.Add('content', Content);
    end;

    local procedure GetContent(var PDFViewerBuffer: Record "PDF Viewer Buffer"; var ContentType: Text; var Content: Text)
    var
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        SourceTableFilter: Integer;
        SourceIdFilter: Text;
        FieldIdFilter: Integer;
    begin
        if Evaluate(SourceTableFilter, PDFViewerBuffer.GetFilter(SourceTableId)) then;
        SourceIdFilter := PDFViewerBuffer.GetFilter(SourceId);
        if Evaluate(FieldIdFilter, PDFViewerBuffer.GetFilter(FieldId)) then;

        if (SourceTableFilter = 0) or (SourceIdFilter = '') or (FieldIdFilter = 0) then
            Error(MissingFiltersErr);

        RecordRef.Open(SourceTableFilter);
        RecordRef.GetBySystemId(SourceIdFilter);
        FieldRef := RecordRef.Field(FieldIdFilter);

        GetContentFromFieldRef(FieldRef, ContentType, Content);

        RecordRef.Close();
    end;

    local procedure GetContentFromFieldRef(FieldRef: FieldRef; var ContentType: Text; var Content: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
    begin
        case FieldRef.Type of
            FieldRef.Type::Blob,
            FieldRef.Type::Media:
                begin
                    TempBlob := GetTempBlobFromFldRef(FieldRef);
                    TempBlob.CreateInStream(InStream);
                    ContentType := 'base64';
                    Content := Base64Convert.ToBase64(InStream);
                end;
            FieldRef.Type::Text:
                begin
                    ContentType := 'url';
                    Content := FieldRef.Value;
                end;
            else
                Error(UnsupportedDataTypeErr, FieldRef.Type);
        end
    end;

    local procedure GetTempBlobFromFldRef(FieldRef: FieldRef) TempBlob: Codeunit "Temp Blob"
    var
        TenantMedia: Record "Tenant Media";
    begin
        case FieldRef.Type of
            FieldRef.Type::Blob:
                TempBlob.FromFieldRef(FieldRef);
            FieldRef.Type::Media:
                begin
                    TenantMedia.Get(Format(FieldRef.Value));
                    TempBlob.FromRecord(TenantMedia, TenantMedia.FieldNo(Content));
                end;
        end
    end;

    var
        MissingFiltersErr: Label 'The source type, source id or field id is missing.';
        UnsupportedDataTypeErr: Label 'The data type %1 is not supported.', Comment = '%1 = Data Type';
}
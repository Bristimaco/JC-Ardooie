table 50131 "PDF Viewer Buffer"
{
    Caption = 'PDF Viewer Buffer';
    TableType = Temporary;

    fields
    {
        field(1; SourceTableId; Integer)
        {
            Caption = 'Source Type';
        }
        field(2; SourceId; Guid)
        {
            Caption = 'Source Id';
        }
        field(3; FieldId; Integer)
        {
            Caption = 'Field Id';
        }
    }
}
table 50132 "JCA PDF Viewer Setup"
{
    Caption = 'PDF Viewer Setup';

    fields
    {
        field(1; Code; code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "PDF Viewer URL"; Text[250])
        {
            Caption = 'PDF Viewer URL';
            DataClassification = SystemMetadata;
        }
    }
}
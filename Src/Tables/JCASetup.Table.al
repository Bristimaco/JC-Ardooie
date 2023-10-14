table 50100 "JCA Setup"
{
    Caption = 'Setup';

    fields
    {
        field(1; Code; code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "Send Test Mails"; Boolean)
        {
            Caption = 'Send Test Mails';
            DataClassification = SystemMetadata;
        }
        field(3; "Test E-Mail Address"; Text[100])
        {
            Caption = 'Test E-Mail Address';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; Code)
        { }
    }
}
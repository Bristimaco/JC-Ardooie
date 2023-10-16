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
        field(4; "Training Session Nos."; code[20])
        {
            Caption = 'Training Session Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(5; "Event Nos."; code[20])
        {
            Caption = 'Event Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(6; "Contact Nos."; code[20])
        {
            Caption = 'Contact Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(PK; Code)
        { }     
    }

    var
        Item: record Item;
}
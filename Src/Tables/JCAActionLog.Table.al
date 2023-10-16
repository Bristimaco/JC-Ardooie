table 50116 "JCA Action Log"
{
    Caption = 'Action Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Application Action"; enum "JCA Application Action")
        {
            Caption = 'Application Action';
            DataClassification = SystemMetadata;
        }
        field(3; Description; text[250])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(4; "Logged on"; DateTime)
        {
            Caption = 'Logged on';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; "Logged by"; Code[50])
        {
            Caption = 'Logged by';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(6; "Related to id"; RecordId)
        {
            Caption = 'Related to id';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        { }
    }

    trigger OnInsert()
    begin
        validate("Logged by", UserId());
        Validate("Logged on", CurrentDateTime());
    end;

}
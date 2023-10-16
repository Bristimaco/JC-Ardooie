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
    }

    keys
    {
        key(PK; "Entry No.")
        { }
    }
}
table 50123 "JCA Result Image"
{
    Caption = 'Result Image';

    fields
    {
        field(1; Result; enum "JCA Event Result")
        {
            Caption = 'Result';
            DataClassification = SystemMetadata;
        }
        field(2; "Result Image"; MediaSet)
        {
            Caption = 'Result Image';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        Key(PK; Result)
        { }
    }
}
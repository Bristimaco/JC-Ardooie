table 50104 "JCA Age Group"
{
    Caption = 'Age Group';

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; Gender; enum "JCA Gender")
        {
            Caption = 'Gender';
            DataClassification = SystemMetadata;
        }
        field(3; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region".Code;
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(5; "Max Age"; Integer)
        {
            Caption = 'Max. Age';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; Code, "Country Code", Gender)
        { }
        key(AgeGroupUpdate; "Country Code", Gender, "Max Age")
        { }
    }
}
table 50103 "JCA Weight Group"
{
    Caption = 'Weight Group';
    LookupPageId = "JCA Weight Groups";
    DrillDownPageId = "JCA Weight Groups";

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; Gender; Enum "JCA Gender")
        {
            Caption = 'Gender';
            DataClassification = SystemMetadata;
        }
        field(3; "Age Group"; Code[20])
        {
            Caption = 'Age Group';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Age Group".Code where(Gender = field(Gender));
        }
        field(4; "Max. Weight"; Decimal)
        {
            Caption = 'Max. Weight';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; Code, Gender, "Age Group")
        { }
    }
}
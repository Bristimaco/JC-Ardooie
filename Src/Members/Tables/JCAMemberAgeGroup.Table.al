Table 50109 "JCA Member Age Group"
{
    Caption = 'Member Age Group';

    fields
    {
        field(1; "Member License ID"; Code[20])
        {
            Caption = 'License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID" where("Member Type" = filter(Judoka | Both));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                CalcFields(Gender);
            end;
        }
        field(2; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region".Code;
        }
        field(3; Gender; enum "JCA Gender")
        {
            Caption = 'Gender';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member".Gender where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(4; "Age Group Code"; Code[10])
        {
            Caption = 'Age Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Age Group".Code where(Gender = field(Gender), "Country Code" = field("Country Code"));
            ValidateTableRelation = false;
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Age Group Description");
            end;
        }
        field(5; "Age Group Description"; text[30])
        {
            Caption = 'Age Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Age Group".Description where(Gender = field(Gender), Code = field("Age Group Code"), "Country Code" = field("Country Code")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Member License ID", "Country Code", "Age Group Code")
        { }
    }
}
table 50111 "JCA Event Age Group"
{
    Caption = 'Event Age Group';

    fields
    {
        field(1; "Event ID"; Integer)
        {
            Caption = 'Event ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Event".ID;

            trigger OnValidate()
            var
                JCAEvent: Record "JCA Event";
            begin
                If JCAEvent.Get("Event ID") then
                    validate("Country Code", JCAEvent."Country Code");
            end;
        }
        field(2; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Event"."Country Code" where(ID = field("Event ID"));
            Editable = false;
        }
        field(3; Gender; enum "JCA Gender")
        {
            Caption = 'Gender';
            DataClassification = SystemMetadata;
        }
        field(4; "Age Group Code"; Code[20])
        {
            Caption = 'Age Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Age Group".Code where("Country Code" = field("Country Code"), Gender = field(Gender));

            trigger OnValidate()
            begin
                CalcFields("Age Group Description");
            end;
        }
        field(5; "Age Group Description"; Text[50])
        {
            Caption = 'Age Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Age Group".Description where("Country Code" = field("Country Code"), Gender = field(Gender), Code = field("Age Group Code")));
            Editable = false;
        }
        field(6; "Weigh-In Start Time"; Time)
        {
            Caption = 'Weigh-In Start Time';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Event ID", "Country Code", gender, "Age Group Code")
        { }
    }
}
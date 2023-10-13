table 50112 "JCA Event Participant"
{
    Caption = 'Event Participant';

    fields
    {
        field(1; "Event ID"; Integer)
        {
            Caption = 'Event ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Event".ID;

            trigger OnValidate()
            var
                JCAEvent: record "JCA Event";
            begin
                JCAEvent.Reset();
                if JCAEvent.get("Event ID") then begin
                    validate("Country Code", JCAEvent."Country Code");
                end;
            end;
        }
        field(2; "Member License ID"; Code[20])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID";

            trigger OnValidate()
            var
                JCAMember: record "JCA Member";
            begin
                JCAMember.Reset();
                if JCAMember.Get("Member License ID") then begin
                    Validate(Gender, JCAMember.Gender);
                end;
                calcfields("Member Full Name");
            end;
        }
        field(3; "Country Code"; Code[20])
        {
            Caption = 'Country Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region".Code;
        }
        field(4; Gender; Enum "JCA Gender")
        {
            Caption = 'Gender';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; "Member Full Name"; Text[150])
        {
            Caption = 'Member Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(6; Invited; Boolean)
        {
            Caption = 'Invited';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(7; Registered; Boolean)
        {
            Caption = 'Registered';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(8; "Age Group Code"; Code[10])
        {
            Caption = 'Age Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Age Group".Code where("Country Code" = field("Country Code"), Gender = field(Gender));

            trigger OnValidate()
            begin
                CalcFields("Age Group Description");
            end;

        }
        field(9; "Age Group Description"; text[50])
        {
            Caption = 'Age Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Age Group".Description where("Country Code" = field("Country Code"), Gender = field(Gender), Code = field("Age Group Code")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Event ID", "Member License ID")
        { }
    }
}
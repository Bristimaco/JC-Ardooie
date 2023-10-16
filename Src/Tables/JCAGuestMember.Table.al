table 50119 "JCA Guest Member"
{
    Caption = 'Guest Member';
    DrillDownPageId = "JCA Guest Members";
    LookupPageId = "JCA Guest Members";

    fields
    {
        field(1; "License ID"; Code[50])
        {
            Caption = 'License ID';
            DataClassification = SystemMetadata;
        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                ManageFullName();
            end;
        }
        field(3; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                ManageFullName();
            end;
        }
        field(4; "Full Name"; Text[150])
        {
            Caption = 'Full Name';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = SystemMetadata;
        }
        field(6; Gender; enum "JCA Gender")
        {
            Caption = 'Gender';
            DataClassification = SystemMetadata;
        }
        field(7; "E-Mail"; text[100])
        {
            Caption = 'E-Mail';
            DataClassification = SystemMetadata;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = SystemMetadata;
        }
        field(9; Belt; enum "JCA Belt")
        {
            caption = 'Belt';
            DataClassification = SystemMetadata;
        }
        field(10; Dan; Integer)
        {
            Caption = 'Dan';
            DataClassification = SystemMetadata;
        }
        field(11; "Club No."; Code[20])
        {
            Caption = 'Club No.';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Club"."No." where("Our Club" = const(false));

            trigger OnValidate()
            begin
                CalcFields("Club Name");
            end;
        }
        field(12; "Club Name"; Text[100])
        {
            Caption = 'Club Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Club".Name where("No." = field("Club No.")));
            Editable = false;
        }
        field(13; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = SystemMetadata;
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "License ID")
        { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "License ID", "Full Name")
        { }
    }

    local procedure ManageFullName()
    begin
        "Full Name" := '';
        if ("First Name" <> '') and ("Last Name" <> '') then
            validate("Full Name", "Last Name" + ' ' + "First Name");
    end;

}
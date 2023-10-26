table 50118 "JCA Club"
{
    Caption = 'Club';
    DrillDownPageId = "JCA Clubs";
    LookupPageId = "JCA Clubs";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(3; "Contact Person"; Text[150])
        {
            Caption = 'Contact Person';
            DataClassification = SystemMetadata;
        }
        field(4; "E-Mail"; Text[100])
        {
            Caption = 'E-Mail';
        }
        field(5; "Phone No."; Text[20])
        {
            Caption = 'Phone No.';
            DataClassification = SystemMetadata;
        }
        field(6; "Our Club"; Boolean)
        {
            Caption = 'Our Club';
            DataClassification = SystemMetadata;
        }
        field(7; Members; Integer)
        {
            Caption = 'Members';
            FieldClass = FlowField;
            CalcFormula = count("JCA Guest Member" where("Club No." = field("No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        { }
        key(Club; "Our Club")
        { }
    }
}
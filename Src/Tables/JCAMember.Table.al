table 50101 "JCA Member"
{
    Caption = 'Member';
    LookupPageId = "JCA Members";
    DrillDownPageId = "JCA Members";

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

            trigger OnValidate()
            begin
                UpdateAgeGroup();
            end;
        }
        field(6; "Member Since"; Date)
        {
            Caption = 'Member Since';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                CalcFields("Active Member");
            end;
        }
        field(7; "Member Until"; Date)
        {
            Caption = 'Member Until';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin                
                CalcFields("Active Member");
                if not "Active Member" then
                    RemoveFromTrainingGroups();
            end;
        }
        field(8; "Active Member"; Boolean)
        {
            Caption = 'Active Member';
            FieldClass = FlowField;
            CalcFormula = exist("JCA Member" where("Member Until" = field("Date Filter")));
            Editable = false;
        }
        field(9; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(10; Gender; enum "JCA Gender")
        {
            Caption = 'Gender';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                UpdateAgeGroup();
            end;
        }
        field(11; Age; Integer)
        {
            Caption = 'Age';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(12; "Age Group Code"; Code[10])
        {
            Caption = 'Age Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Age Group".Code where(Gender = field(Gender));
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Age Group Description");
            end;
        }
        field(13; "Age Group Description"; text[30])
        {
            Caption = 'Age Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Age Group".Description where(Gender = field(Gender), Code = field("Age Group Code")));
            Editable = false;
        }        
    }

    keys
    {
        key(PK; "License ID")
        { }
        key(AgeGroup1; "Date of Birth")
        { }
        key(AgeGoup2; "Age Group Code")
        { }
    }

    local procedure RemoveFromTrainingGroups()
    var
        JCATrainingGroupMember: record "JCA Training Group Member";
    begin
        JCATrainingGroupMember.Reset();
        JCATrainingGroupMember.setrange("Member License ID","License ID");
        JCATrainingGroupMember.DeleteAll(true);
    end;

    local procedure ManageFullName()
    begin
        "Full Name" := '';
        if ("First Name" <> '') and ("Last Name" <> '') then
            validate("Full Name", "First Name" + ' ' + "Last Name");
    end;

    local procedure UpdateAgeGroup()
    var
        JCAAgeGroup: record "JCA Age Group";
        CurrentAge: Integer;
    begin
        GetCurrentAgeGroup(JCAAgeGroup, CurrentAge, '');
        if CurrentAge <> 0 then begin
            validate(Age, CurrentAge);
            validate("Age Group Code", JCAAgeGroup.Code);
        end else begin
            validate(Age, 0);
            validate("Age Group Code", '');
        end;
    end;

    procedure GetCurrentAgeGroup(var JCAAgeGroup: record "JCA Age Group"; var CurrentAge: Integer; CountryCode: code[10]): Boolean
    var
        CountryRegion: record "Country/Region";
        AgeGroupSwitchDate: Date;
        AgeSwitchMonth: Integer;
        PastAgeLimitSwitchDate: Boolean;
        Birthyear: integer;
        Currentyear: Integer;
    begin
        CurrentAge := 0;
        if "Date of Birth" = 0D then
            exit(false);

        if CountryCode = '' then
            AgeSwitchMonth := 1
        else begin
            CountryRegion.Reset();
            CountryRegion.get(CountryCode);
            AgeSwitchMonth := CountryRegion."JCA Age Group Switch Month";
        end;
        AgeGroupSwitchDate := DMY2Date(1, AgeSwitchMonth, Date2DMY(Today(), 3));

        PastAgeLimitSwitchDate := false;
        if AgeGroupSwitchDate >= Rec."Date of Birth" then
            PastAgeLimitSwitchDate := true;

        Birthyear := Date2DMY(Rec."Date of Birth", 3);
        Currentyear := Date2DMY(Today(), 3);
        CurrentAge := Currentyear - Birthyear;

        JCAAgeGroup.Reset();
        JCAAgeGroup.SetCurrentKey("Country Code", Gender, "Max Age");
        JCAAgeGroup.setrange(Gender, Gender);
        JCAAgeGroup.SetFilter("Max Age", '>%1', CurrentAge - 1);
        exit(JCAAgeGroup.FindFirst());
    end;
}
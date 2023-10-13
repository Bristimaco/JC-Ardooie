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
                UpdateAgeGroups();
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
                UpdateAgeGroups();
            end;
        }
        field(11; Age; Integer)
        {
            Caption = 'Age';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(14; "Member Type"; Enum "JCA Member Type")
        {
            Caption = 'Member Type';
            DataClassification = SystemMetadata;
        }
        field(15; "E-Mail"; text[100])
        {
            Caption = 'E-Mail';
            DataClassification = SystemMetadata;
        }
        field(16; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "License ID")
        { }
        key(AgeGroup1; "Date of Birth")
        { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "License ID", "Full Name")
        { }
    }

    trigger OnDelete()
    var
        JCATrainingGroupMember: record "JCA Training Group Member";
        JCAMemberAgeGroup: record "JCA Member Age Group";
    begin
        JCATrainingGroupMember.Reset();
        JCATrainingGroupMember.setrange("Member License ID", "License ID");
        JCATrainingGroupMember.deleteall(true);

        JCAMemberAgeGroup.Reset();
        JCAMemberAgeGroup.setrange("Member License ID", "License ID");
        JCAMemberAgeGroup.deleteall(true);
    end;

    local procedure RemoveFromTrainingGroups()
    var
        JCATrainingGroupMember: record "JCA Training Group Member";
    begin
        JCATrainingGroupMember.Reset();
        JCATrainingGroupMember.setrange("Member License ID", "License ID");
        JCATrainingGroupMember.DeleteAll(true);
    end;

    local procedure ManageFullName()
    begin
        "Full Name" := '';
        if ("First Name" <> '') and ("Last Name" <> '') then
            validate("Full Name", "First Name" + ' ' + "Last Name");
    end;

    procedure UpdateAgeGroups()
    var
        JCAAgeGroup: record "JCA Age Group";
        CountryRegion: record "Country/Region";
        JCAMemberAgeGroup: record "JCA Member Age Group";
        CurrentAge: Integer;
    begin
        JCAMemberAgeGroup.Reset();
        JCAMemberAgeGroup.setrange("Member License ID", "License ID");
        JCAMemberAgeGroup.DeleteAll(true);

        CountryRegion.Reset();
        if CountryRegion.Findset() then
            repeat
                if GetCurrentAgeGroup(JCAAgeGroup, CurrentAge, CountryRegion.Code) then
                    if CurrentAge <> 0 then begin
                        validate(Age, CurrentAge);
                        JCAMemberAgeGroup.Reset();
                        JCAMemberAgeGroup.init();
                        JCAMemberAgeGroup.validate("Member License ID", "License ID");
                        JCAMemberAgeGroup.Validate("Country Code", CountryRegion.code);
                        JCAMemberAgeGroup.validate("Age Group Code", JCAAgeGroup.Code);
                        JCAMemberAgeGroup.Insert(True);
                    end;
            until CountryRegion.Next() = 0;
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
        JCAAgeGroup.setrange("Country Code", CountryCode);
        JCAAgeGroup.SetFilter("Max Age", '>%1', CurrentAge - 1);
        exit(JCAAgeGroup.FindFirst());
    end;
}
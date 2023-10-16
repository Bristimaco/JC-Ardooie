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
                UpdateAgeGroups(today(), true, tempJCAMemberAgeGroup);
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
                UpdateAgeGroups(Today(), true, tempJCAMemberAgeGroup);
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

            trigger OnValidate()
            begin
                UpdateAgeGroups(Today(), true, tempJCAMemberAgeGroup);
            end;
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
        field(17; Belt; enum "JCA Belt")
        {
            caption = 'Belt';
            DataClassification = SystemMetadata;
        }
        field(18; Dan; Integer)
        {
            Caption = 'Dan';
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
            validate("Full Name", "Last Name" + ' ' + "First Name");
    end;

    procedure UpdateAgeGroups(CalculationDate: Date; SaveData: Boolean; var tempJCAMemberAgeGroup: record "JCA Member Age Group" temporary)
    var
        JCAMemberManagement: Codeunit "JCA Member Management";
    begin
        clear(JCAMemberManagement);
        JCAMemberManagement.UpdateAgeGroups(Rec, CalculationDate, SaveData, tempJCAMemberAgeGroup);
    end;

    var
        tempJCAMemberAgeGroup: record "JCA Member Age Group" temporary;
}
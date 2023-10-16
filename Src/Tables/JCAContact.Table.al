table 50114 "JCA Contact"
{
    Caption = 'Contact';
    DrillDownPageId = "JCA Contacts";
    LookupPageId = "JCA Contacts";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
            DataClassification = SystemMetadata;

            Trigger OnValidate()
            begin
                ManageFullName();
            end;
        }
        field(3; "Last Name"; text[100])
        {
            Caption = 'Last Name';
            DataClassification = SystemMetadata;

            Trigger OnValidate()
            begin
                ManageFullname();
            end;
        }
        field(4; "Full Name"; Text[150])
        {
            Caption = 'Full Name';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; "E-Mail"; text[100])
        {
            Caption = 'E-Mail';
            DataClassification = SystemMetadata;
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "No.")
        { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Full Name")
        { }
    }

    trigger OnInsert()
    var
        JCASetup: Record "JCA Setup";
        NoSeriesManagement: codeunit NoSeriesManagement;
    begin
        JCASetup.Reset();
        JCASetup.get();
        JCASetup.testfield("Contact Nos.");
        Validate("No.", NoSeriesManagement.GetNextNo(JCASetup."Contact Nos.", Today(), true));
    end;

    local procedure ManageFullName()
    begin
        "Full Name" := '';
        if ("First Name" <> '') and ("Last Name" <> '') then
            validate("Full Name", "Last Name" + ' ' + "First Name");
    end;
}
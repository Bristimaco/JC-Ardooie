table 50107 "JCA Training Group Member"
{
    Caption = 'Training Group Member';

    fields
    {
        field(1; "Training Group Code"; Code[20])
        {
            Caption = 'Training Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Training Group".Code;

            trigger OnValidate()
            begin
                CalcFields("Training Group Description");
            end;
        }
        field(2; "Member License ID"; Code[50])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID" where("Active Membership" = field("Membership Filter"), "Membersh. Start Date Filter" = field("Membersh. Start Date Filter"), "Membersh. End Date Filter" = field("Membersh. End Date Filter"), "Member Type" = filter(Judoka | Both));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                CalcFields("Member Full Name");
            end;
        }
        field(3; "Training Group Description"; Text[50])
        {
            Caption = 'Training Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Training Group".Description where(Code = field("Training Group Code")));
            Editable = false;
        }
        field(4; "Member Full Name"; text[150])
        {
            Caption = 'Member Full name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(5; "Membersh. Start Date Filter"; Date)
        {
            Caption = 'Membership Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(6; "Membersh. End Date Filter"; Date)
        {
            Caption = 'Membership End Date Filter';
            FieldClass = FlowFilter;
        }
        field(7; "Membership Filter"; Code[20])
        {
            Caption = 'Membership Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Training Group Code", "Member License ID")
        { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Member License ID", "Member Full Name")
        { }
    }
}
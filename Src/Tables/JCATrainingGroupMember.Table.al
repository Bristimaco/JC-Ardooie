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
        field(2; "Member License ID"; Code[20])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID" where("Active Member" = const(true));

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
    }

    keys
    {
        key(PK; "Training Group Code", "Member License ID")
        { }
    }
}
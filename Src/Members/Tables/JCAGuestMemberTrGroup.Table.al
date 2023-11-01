table 50120 "JCA Guest Member Tr. Group"
{
    Caption = 'Guest Member Training Group';

    fields
    {
        field(1; "Guest Member License ID"; Code[50])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Guest Member"."License ID";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                CalcFields("Guest Member Full Name");
            end;
        }
        field(2; "Training Group Code"; Code[20])
        {
            Caption = 'Training Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Training Group".Code where("Open for Other Clubs" = const(true));

            trigger OnValidate()
            begin
                CalcFields("Training Group Description");
            end;
        }
        field(3; "Training Group Description"; Text[50])
        {
            Caption = 'Training Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Training Group".Description where(Code = field("Training Group Code")));
            Editable = false;
        }
        field(4; "Guest Member Full Name"; text[150])
        {
            Caption = 'Member Full name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Guest Member"."Full Name" where("License ID" = field("Guest Member License ID")));
            Editable = false;
        }
        field(5; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = SystemMetadata;
            InitValue = true;
        }
    }
}
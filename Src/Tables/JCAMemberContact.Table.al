table 50115 "JCA Member Contact"
{
    Caption = 'Member Contact';

    fields
    {
        field(1; "Member License ID"; Code[20])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID";

            trigger OnValidate()
            begin
                CalcFields("Member Full Name");
            end;
        }
        field(2; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = "JCA Contact"."No.";

            trigger OnValidate()
            begin

            end;
        }
        field(3; "Member Full Name"; Text[150])
        {
            Caption = 'Member Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(4; "Contact Full Name"; Text[150])
        {
            Caption = 'Contact Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Contact"."Full Name" where("No." = field("Contact No.")));
            Editable = false;
        }
        field(5; "Contact E-Mail"; Text[100])
        {
            Caption = 'Contact E-Mail';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Contact"."E-Mail" where("No." = field("Contact No.")));
            Editable = false;
        }
        field(6; "Contact Phone No."; Text[30])
        {
            Caption = 'Contact Phone No.';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Contact"."Phone No." where("No." = field("Contact No.")));
            Editable = false;
        }
        field(7; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Member License ID", "Contact No.")
        { }
    }
}
table 50100 "JCA Setup"
{
    Caption = 'Setup';

    fields
    {
        field(1; Code; code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "Send Test Mails"; Boolean)
        {
            Caption = 'Send Test Mails';
            DataClassification = SystemMetadata;
        }
        field(3; "Test E-Mail Address"; Text[100])
        {
            Caption = 'Test E-Mail Address';
            DataClassification = SystemMetadata;
        }
        field(4; "Training Session Nos."; code[20])
        {
            Caption = 'Training Session Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(5; "Event Nos."; code[20])
        {
            Caption = 'Event Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(6; "Contact Nos."; code[20])
        {
            Caption = 'Contact Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(7; "Training G/L Account No."; Code[20])
        {
            Caption = 'Training G/L Account No.';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                CalcFields("Training G/L Acc. Description");
            end;
        }
        field(8; "Training G/L Acc. Description"; text[100])
        {
            Caption = 'Training G/L Account Description';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account".Name where("No." = field("Training G/L Account No.")));
            Editable = false;
        }
        field(9; "Participant Unit Price"; Decimal)
        {
            Caption = 'Participant Unit Price';
            DataClassification = SystemMetadata;
        }
        field(10; "Trainer Unit Price"; Decimal)
        {
            Caption = 'Trainer Unit Price';
            DataClassification = SystemMetadata;
        }
        field(11; "Default Membership Code"; Code[20])
        {
            Caption = 'Default Membership Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Membership".Code;
        }
        field(12; "Membership Renewal Period"; DateFormula)
        {
            Caption = 'Membership Renewal Period';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; Code)
        { }
    }
}
table 50105 "JCA Training Session"
{
    Caption = 'Training Session';
    DrillDownPageId = "JCA Training Sessions";
    LookupPageId = "JCA Training Sessions";

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }
        field(3; "Training Group Code"; Code[20])
        {
            Caption = 'Training Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Training Group".Code;

            trigger OnValidate()
            begin
                CalcFields("Training Group Description");
            end;
        }
        field(4; "Training Group Description"; Text[50])
        {
            Caption = 'Training Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Training Group".Description where(Code = field("Training Group Code")));
            Editable = false;
        }
        field(5; Status; enum "JCA Training Session Status")
        {
            Caption = 'Status';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }
}
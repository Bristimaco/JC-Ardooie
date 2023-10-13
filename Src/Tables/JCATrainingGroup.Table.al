table 50106 "JCA Training Group"
{
    Caption = 'Training Group';
    LookupPageId = "JCA Training Groups";
    DrillDownPageId = "JCA Training Groups";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(3; members; Integer)
        {
            Caption = 'Members';
            FieldClass = FlowField;
            CalcFormula = count("JCA Training Group Member" where("Training Group Code" = field(Code)));
            Editable = false;
        }
    }

    keys
    {
        key(PK; Code)
        { }
    }

    trigger OnDelete()
    var
        JCATrainingGroupMember: record "JCA Training Group Member";
    begin
        JCATrainingGroupMember.reset();
        JCATrainingGroupMember.setrange("Training Group Code", Code);
        JCATrainingGroupMember.deleteall(true);
    end;
}
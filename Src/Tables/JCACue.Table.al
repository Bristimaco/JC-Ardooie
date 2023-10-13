table 50102 "JCA Cue"
{
    Caption = 'JCA Cue';

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(3; "Active Members"; Integer)
        {
            Caption = 'Active Members';
            FieldClass = FlowField;
            CalcFormula = count("JCA Member" where("Active Member" = const(true), "Date Filter" = field("Date Filter")));
            Editable = false;
        }
        field(4; "Inactive Members"; Integer)
        {
            Caption = 'Inactive Members';
            FieldClass = FlowField;
            CalcFormula = count("JCA Member" where("Active Member" = const(false), "Date Filter" = field("Date Filter")));
            Editable = false;
        }
    }

    keys
    {
        key(PK;Code)
        {}
    }
}
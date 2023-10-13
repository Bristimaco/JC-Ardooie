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
        field(5; "Open Training Sessions"; Integer)
        {
            Caption = 'Open Training Sessions';
            FieldClass = FlowField;
            CalcFormula = count("JCA Training Session" where(Status = const(Open)));
            Editable = false;
        }
        field(6; "Closed Training Sessions"; Integer)
        {
            Caption = 'Closed Training Sessions';
            FieldClass = FlowField;
            CalcFormula = count("JCA Training Session" where(Status = const(Closed)));
            Editable = false;
        }
        field(7; "Training Sessions Today"; Integer)
        {
            Caption = 'Training Sessions Today';
            FieldClass = FlowField;
            CalcFormula = count("JCA Training Session" where(Status = const(Open), Date = field("Training Date Filter")));
            Editable = false;
        }
        field(8; "Training Date Filter"; Date)
        {
            Caption = 'Trainging Date Filter';
            FieldClass = FlowFilter;
        }
        field(9; "New Tournaments"; Integer)
        {
            Caption = 'New Tournaments';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Tournament), Status = const(New)));
            Editable = false;
        }
        field(10; "New Stages"; Integer)
        {
            Caption = 'New Stages';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Stage), Status = const(New)));
            Editable = false;
        }
        field(11; "New Chiai"; Integer)
        {
            Caption = 'New Chiai';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Chiai), Status = const(New)));
            Editable = false;
        }
    }

    keys
    {
        key(PK; Code)
        { }
    }
}
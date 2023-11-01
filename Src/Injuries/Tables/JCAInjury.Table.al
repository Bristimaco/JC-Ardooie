table 50128 "JCA Injury"
{
    Caption = 'Injury';
    LookupPageId = "JCA Injuries";
    DrillDownPageId = "JCA Injuries";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Member License ID"; Code[50])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID";

            trigger OnValidate()
            begin
                CalcFields("Member Full Name");
            end;
        }
        field(3; "Related To"; enum "JCA Injury Relation")
        {
            Caption = 'Related To';
            DataClassification = SystemMetadata;
        }
        field(4; "Related To No."; code[20])
        {
            Caption = 'Related To No.';
            DataClassification = SystemMetadata;
            TableRelation = if ("Related To" = const("Training Session")) "JCA Training Session"."No." else
            if ("Related To" = const("Event")) "JCA Event"."No.";

            trigger OnValidate()
            var
                JCAEvent: record "JCA Event";
                JCATrainingSession: record "JCA Training Session";
            begin
                case "Related To" of
                    "Related To"::"Training Session":
                        begin
                            JCATrainingSession.reset();
                            if JCATrainingSession.get("Related To No.") then begin
                                JCATrainingSession.CalcFields("Training Group Description");
                                validate("Related To Description", JCATrainingSession."Training Group Description");
                                validate(Date, JCATrainingSession.Date);
                            end;
                        end;
                    "Related To"::"Event":
                        begin
                            JCAEvent.Reset();
                            if JCAEvent.get("Related To No.") then begin
                                validate("Related To Description", JCAEvent.Description);
                                Validate(Date, JCAEvent.Date);
                            end;
                        end;
                end;
            end;
        }
        field(5; "Member Full Name"; Text[150])
        {
            Caption = 'Member Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(6; "Related To Description"; Text[100])
        {
            Caption = 'Releated To Description';
            DataClassification = SystemMetadata;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }
        field(8; "Short Description"; text[80])
        {
            Caption = 'Injury Description';
            DataClassification = SystemMetadata;
        }
        field(9; Status; enum "JCA Injury Status")
        {
            Caption = 'Injury Status';
            DataClassification = SystemMetadata;
        }
        field(10; "Insurance Status"; enum "JCA Insurance Status")
        {
            Caption = 'Insurance Status';
            DataClassification = SystemMetadata;
        }
        field(11; "Injury Description"; Blob)
        {
            Caption = 'Injury Description';
            DataClassification = SystemMetadata;
        }
        field(12; "Expected End Date"; Date)
        {
            Caption = 'Expected End Date';
            DataClassification = SystemMetadata;
        }
    }


    keys
    {
        key(PK; "No.")
        { }
    }

    trigger OnInsert()
    var
        JCASetup: record "JCA Setup";
        NoSeriesManagement: codeunit NoSeriesManagement;
    begin
        JCASetup.Reset();
        JCASetup.get();
        JCASetup.TestField("Injury Nos.");
        clear(NoSeriesManagement);
        validate("No.", NoSeriesManagement.GetNextNo(JCASetup."Injury Nos.", Today(), true));
    end;

    procedure ReadInjuryDescription(var InjuryDescription: Text)
    var
        InStream: InStream;
    begin
        CalcFields("Injury Description");
        "Injury Description".CreateInStream(InStream);
        InStream.Read(InjuryDescription);
    end;

    procedure WriteInjuryDescription(InjuryDescription: Text)
    var
        OutStream: OutStream;
    begin
        "Injury Description".CreateOutStream(OutStream);
        OutStream.Write(InjuryDescription, StrLen(InjuryDescription));
        Rec.Modify(true);
    end;
}
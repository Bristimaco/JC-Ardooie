table 50127 "JCA HTML Gen. CSS Template"
{
    Caption = 'HTML Generator CSS Template';
    DrillDownPageId = "JCA HTML Gen. CSS Templates";
    LookupPageId = "JCA HTML Gen. CSS Templates";

    fields
    {
        field(1; "HTML Gen. CSS Type"; enum "JCA HTML Gen. CSS Type")
        {
            Caption = 'HTML Gen. CSS Type';
            DataClassification = SystemMetadata;
        }
        field(2; "CSS Template Data"; Blob)
        {
            Caption = 'CSS Template Data';
            DataClassification = SystemMetadata;
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = SystemMetadata;
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = SystemMetadata;
        }
        field(5; "Event No."; Code[20])
        {
            Caption = 'Event No.';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Event"."No.";
        }
    }

    keys
    {
        key(PK; "HTML Gen. CSS Type")
        { }
    }

    procedure ReadTemplateData(var TemplateData: Text)
    var
        InStream: InStream;
    begin
        CalcFields("CSS Template Data");
        "CSS Template Data".CreateInStream(InStream);
        InStream.Read(TemplateData);
    end;

    procedure WriteTemplateData(TemplateData: Text)
    var
        OutStream: OutStream;
    begin
        "CSS Template Data".CreateOutStream(OutStream);
        OutStream.Write(TemplateData, StrLen(TemplateData));
        Rec.Modify(true);
    end;

    procedure OpenTemplateEditor()
    var
        JCAHTMLGenCSSTemplate: record "JCA HTML Gen. CSS Template";
        JCAHTMLGenCSSEditor: page "JCA HTML Gen. CSS Editor";
    begin
        JCAHTMLGenCSSTemplate.Reset();
        JCAHTMLGenCSSTemplate.setrange("HTML Gen. CSS Type", rec."HTML Gen. CSS Type");
        JCAHTMLGenCSSTemplate.findfirst();

        case "HTML Gen. CSS Type" of
            "HTML Gen. CSS Type"::Calendar, "HTML Gen. CSS Type"::"Event Result":
                begin
                    clear(JCAHTMLGenCSSEditor);
                    JCAHTMLGenCSSEditor.SetTableView(JCAHTMLGenCSSTemplate);
                    JCAHTMLGenCSSEditor.run();
                end;
        end;
    end;
}
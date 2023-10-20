table 50126 "JCA Mail Message Template"
{
    Caption = 'Mail Message Template';
    DrillDownPageId = "JCA Mail Message Templates";
    LookupPageId = "JCA Mail Message Templates";

    fields
    {
        field(1; "Mail Message Type"; enum "JCA Mail Message Type")
        {
            Caption = 'Mail Message Type';
            DataClassification = SystemMetadata;
        }
        field(2; "Mail Template Data"; Blob)
        {
            Caption = 'Mail Message Data';
            DataClassification = SystemMetadata;
        }
        field(3; "Member License ID"; Code[20])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID";
        }
        field(4; "Event Result"; Enum "JCA Event Result")
        {
            Caption = 'Event Result';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Mail Message Type")
        { }
    }

    procedure ReadTemplateData(var TemplateData: Text)
    var
        InStream: InStream;
    begin
        CalcFields("Mail Template Data");
        "Mail Template Data".CreateInStream(InStream);
        InStream.Read(TemplateData);
    end;

    procedure WriteTemplateData(TemplateData: Text)
    var
        OutStream: OutStream;
    begin
        "Mail Template Data".CreateOutStream(OutStream);
        OutStream.Write(TemplateData, StrLen(TemplateData));
        Rec.Modify(true);
    end;

    procedure OpenTemplateEditor()
    var
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        JCAEventResultMailEditor: page "JCA Event Result Mail Editor";
    begin
        JCAMailMessageTemplate.Reset();
        JCAMailMessageTemplate.setrange("Mail Message Type", rec."Mail Message Type");
        JCAMailMessageTemplate.findfirst();

        case "Mail Message Type" of
            "Mail Message Type"::"Event Result":
                begin
                    JCAEventResultMailEditor.SetTableView(JCAMailMessageTemplate);
                    JCAEventResultMailEditor.run();
                end;
        end;
    end;
}
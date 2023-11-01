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
        field(3; "Member License ID"; Code[50])
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
        field(5; "Event No."; Code[20])
        {
            Caption = 'Event No.';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Event"."No.";
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
        JCAEventMailing: Interface JCAEventMailing;
    begin
        JCAMailMessageTemplate.reset();
        JCAMailMessageTemplate.setrange("Mail Message Type", rec."Mail Message Type");
        JCAMailMessageTemplate.findfirst();
        JCAEventMailing := JCAMailMessageTemplate."Mail Message Type";
        JCAEventMailing.EditTemplate(JCAMailMessageTemplate);
    end;
}
table 50126 "JCA Mail Message Template"
{
    Caption = 'Mail Messaeg Template';
    DrillDownPageId = "JCA Mail Message Templates";
    LookupPageId = "JCA Mail Message Templates";

    fields
    {
        field(1; "Mail Message Type"; enum "JCA Mail Message Type")
        {
            Caption = 'Mail Messaeg Type';
            DataClassification = SystemMetadata;
        }
        field(2; "Mail Template Data"; Blob)
        {
            Caption = 'Mail Message Data';
            DataClassification = SystemMetadata;
        }
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
}
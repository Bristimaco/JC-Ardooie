table 50123 "JCA Result Image"
{
    Caption = 'Result Image';

    fields
    {
        field(1; Result; enum "JCA Event Result")
        {
            Caption = 'Result';
            DataClassification = SystemMetadata;
        }
        field(2; "Result Image"; MediaSet)
        {
            Caption = 'Result Image';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        Key(PK; Result)
        { }
    }

    procedure GetImage(): Text
    var
        TenantMedia: record "Tenant Media";
        Base64Convert: Codeunit "Base64 Convert";
        Instream: InStream;
        ResultImage: Text;
    begin
        ResultImage := '';
        if Rec."Result Image".Count() <> 0 then begin
            TenantMedia.reset();
            TenantMedia.get(Rec."Result Image".item(1));
            TenantMedia.CalcFields(Content);
            TenantMedia.Content.CreateInStream(InStream);
            ResultImage := Base64Convert.ToBase64(InStream);
        end;
        exit(ResultImage);
    end;
}
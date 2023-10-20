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
        JCAEventResultMailEditor: page "JCA Event Result Mail Editor";
        JCAEvenInvMailEditor: page "JCA Event Inv. Mail Editor";
    begin
        JCAMailMessageTemplate.Reset();
        JCAMailMessageTemplate.setrange("Mail Message Type", rec."Mail Message Type");
        JCAMailMessageTemplate.findfirst();

        case "Mail Message Type" of
            "Mail Message Type"::Invitation:
                begin
                    clear(JCAEvenInvMailEditor);
                    JCAEvenInvMailEditor.SetTableView(JCAMailMessageTemplate);
                    JCAEvenInvMailEditor.run();
                end;
            "Mail Message Type"::"Event Result":
                begin
                    clear(JCAEventResultMailEditor);
                    JCAEventResultMailEditor.SetTableView(JCAMailMessageTemplate);
                    JCAEventResultMailEditor.run();
                end;
        end;
    end;

    procedure ReturnInvitationMailContent(LicenseID: code[20]; EventNo: code[20]): Text
    var
        JCAMember: record "JCA Member";
        JCASetup: Record "JCA Setup";
        JCAEvent: Record "JCA Event";
        MemberName: Text;
        ResultCardLogo: Text;
        EventDescription: Text;
        EventAddress: Text;
        EventPostCode: Text;
        EventCity: Text;
        EventDate: Text;
        RegistrationDueDate: Text;
        TemplateData: Text;
        MailContent: Text;
    begin
        JCAMember.Reset();
        if JCAMember.get(LicenseID) then
            MemberName := JCAMember."First Name";

        ResultCardLogo := '';
        JCASetup.Reset();
        JCASetup.get();
        ResultCardLogo := JCASetup.GetResultCardLogo();

        EventDescription := '';
        EventAddress := '';
        EventPostCode := '';
        EventCity := '';

        JCAEvent.reset();
        if JCAEvent.Get(rec."Event No.") then begin
            EventDescription := JCAEvent.Description;
            EventAddress := JCAEvent.Address;
            EventPostCode := JCAEvent."Post Code";
            EventCity := JCAEvent.City;
            EventDate := format(JCAEvent.Date);
            RegistrationDueDate := format(JCAEvent."Registration Deadline");
        end;
        rec.ReadTemplateData(TemplateData);
        MailContent := StrSubstNo(TemplateData, ResultCardLogo, MemberName, EventDate, EventDescription, RegistrationDueDate, EventAddress, EventPostCode, EventCity);
        exit(MailContent);
    end;

    procedure ReturnEventResultMailContent(LicenseID: code[20]; JCAEventResult: enum "JCA Event Result"): Text
    var
        JCAMember: record "JCA Member";
        JCASetup: Record "JCA Setup";
        JCAResultImage: record "JCA Result Image";
        MemberName: Text;
        MemberPicture: Text;
        ResultCardLogo: Text;
        ResultImage: Text;
        TemplateData: text;
        MailContent: Text;
    begin
        ResultCardLogo := '';
        JCASetup.Reset();
        JCASetup.get();
        ResultCardLogo := JCASetup.GetResultCardLogo();

        JCAMember.Reset();
        if JCAMember.get(LicenseID) then begin
            MemberName := JCAMember."Full Name";
            MemberPicture := JCAMember.GetPicture();
        end;

        JCAResultImage.reset();
        if JCAResultImage.get(JCAEventResult) then
            ResultImage := JCAResultImage.GetImage();

        rec.ReadTemplateData(TemplateData);
        MailContent := StrSubstNo(TemplateData, ResultCardLogo, MemberPicture, ResultImage, MemberName, UpperCase(format(JCAEventResult)));
        exit(MailContent);
    end;

}
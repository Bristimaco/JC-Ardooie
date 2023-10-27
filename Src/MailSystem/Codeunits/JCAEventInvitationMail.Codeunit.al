codeunit 50110 "JCA Event Invitation Mail" implements JCAEventMailing
{
    procedure EditTemplate(var JCAMailMessageTemplate: record "JCA Mail Message Template")
    var
        JCAEventInvMailEditor: page "JCA Event Inv. Mail Editor";
    begin
        clear(JCAEventInvMailEditor);
        JCAEventInvMailEditor.SetTableView(JCAMailMessageTemplate);
        JCAEventInvMailEditor.run();
    end;

    procedure ReturnMailContent(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Text
    var
        JCAMember: record "JCA Member";
        JCASetup: Record "JCA Setup";
        JCAEvent: Record "JCA Event";
        JCAMailMessageTemplate: record "JCA Mail Message Template";
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
        if JCAMember.get(tempJCAMailMessageTemplate."Member License ID") then
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
        if JCAEvent.Get(tempJCAMailMessageTemplate."Event No.") then begin
            EventDescription := JCAEvent.Description;
            EventAddress := JCAEvent.Address;
            EventPostCode := JCAEvent."Post Code";
            EventCity := JCAEvent.City;
            EventDate := format(JCAEvent.Date);
            RegistrationDueDate := format(JCAEvent."Registration Deadline");
        end;
        JCAMailMessageTemplate.Reset();
        JCAMailMessageTemplate.get(tempJCAMailMessageTemplate."Mail Message Type");
        JCAMailMessageTemplate.ReadTemplateData(TemplateData);
        MailContent := StrSubstNo(TemplateData, ResultCardLogo, MemberName, EventDate, EventDescription, RegistrationDueDate, EventAddress, EventPostCode, EventCity);
        exit(MailContent);
    end;
}
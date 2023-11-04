codeunit 50109 "JCA Event Result Mail" implements JCAEventMailing
{
    procedure EditTemplate(var JCAMailMessageTemplate: record "JCA Mail Message Template")
    var
        JCAEventResultMailEditor: page "JCA Event Result Mail Editor";
    begin
        clear(JCAEventResultMailEditor);
        JCAEventResultMailEditor.SetTableView(JCAMailMessageTemplate);
        JCAEventResultMailEditor.run();
    end;

    procedure ReturnMailContent(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Text
    var
        JCAMember: record "JCA Member";
        JCASetup: Record "JCA Setup";
        JCAResultImage: record "JCA Result Image";
        JCAMailMessageTemplate: record "JCA Mail Message Template";
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
        if JCAMember.get(tempJCAMailMessageTemplate."Member License ID") then begin
            MemberName := JCAMember."Full Name";
            MemberPicture := JCAMember.GetPicture();
        end;

        JCAResultImage.reset();
        if JCAResultImage.get(tempJCAMailMessageTemplate."Event Result") then
            ResultImage := JCAResultImage.GetImage();

        JCAMailMessageTemplate.Reset();
        JCAMailMessageTemplate.get(tempJCAMailMessageTemplate."Mail Message Type");
        JCAMailMessageTemplate.ReadTemplateData(TemplateData);
        MailContent := StrSubstNo(TemplateData, ResultCardLogo, MemberPicture, ResultImage, MemberName, UpperCase(format(tempJCAMailMessageTemplate."Event Result")));
        exit(MailContent);
    end;

    procedure SendMail(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Boolean
    var
        JCAEvent: record "JCA Event";
        JCAMember: record "JCA Member";
        JCAContact: record "JCA Contact";
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        MailManagement: codeunit "Mail Management";
        JCAMailManagement: codeunit "JCA Mail System Helper";
        EmailMessage: codeunit "Email Message";
        Email: codeunit Email;
        MailingList: list of [Text[100]];
        MailAddress: text[100];
        MailSubject: text;
        MailBody: TextBuilder;
    begin
        JCAEvent.reset();
        JCAEvent.get(tempJCAMailMessageTemplate."Event No.");
        if not JCAEvent."Send Result Mails" then
            exit;

        clear(MailingList);


        JCAMailMessageTemplate.reset();
        if JCAMailMessageTemplate.get(enum::"JCA Mail Message Type"::"Event Result") then
            JCAMailMessageTemplate.CalcFields("Mail Template Data");

        JCAMember.Reset();
        JCAMember.setrange("Send Result Mails", true);
        if JCAMember.Findset() then
            repeat
                if not MailingList.Contains(JCAMember."E-Mail") then
                    MailingList.Add(JCAMember."E-Mail");
            until JCAMember.Next() = 0;
        JCAContact.reset();
        JCAContact.setrange("Send Result Mails", true);
        if JCAContact.findset() then
            repeat
                if not MailingList.Contains(JCAContact."E-Mail") then
                    MailingList.Add(JCAContact."E-Mail");
            until JCAContact.Next() = 0;

        if MailingList.Count() = 0 then
            exit;

        CreateEventResultMailContent(tempJCAMailMessageTemplate, JCAEvent, MailSubject, MailBody);
        foreach MailAddress in MailingList do begin
            JCAMailManagement.CheckForMailSystemTest(MailAddress);
            clear(MailManagement);
            if MailManagement.CheckValidEmailAddress(MailAddress) then begin
                clear(EmailMessage);
                EmailMessage.Create(MailAddress, MailSubject, MailBody.ToText(), true);
                clear(Email);
                Email.Send(EmailMessage, enum::"Email Scenario"::Default);
            end;
        end;
    end;

    local procedure CreateEventResultMailContent(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder)
    var
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        JCAMember: Record "JCA Member";
        JCAEventMailing: Interface JCAEventMailing;
        EMailContent: Text;
        ResultsLbl: label 'Results for %1 - %2: %3', Comment = '%1 = Event No., %2 = Event Description, %3 = Member Name';
    begin
        JCAMember.Reset();
        JCAMember.get(tempJCAMailMessageTemplate."Member License ID");

        MailSubject := StrSubstNo(ResultsLbl, JCAEvent.Type, JCAEvent.Description, JCAMember."Full Name");

        Clear(MailBody);
        JCAMailMessageTemplate.reset();
        JCAMailMessageTemplate.get(enum::"JCA Mail Message Type"::"Event Result");
        JCAEventMailing := JCAMailMessageTemplate."Mail Message Type";
        tempJCAMailMessageTemplate."Mail Message Type" := JCAMailMessageTemplate."Mail Message Type";
        tempJCAMailMessageTemplate."Member License ID" := JCAMember."License ID";
        tempJCAMailMessageTemplate."Event Result" := tempJCAMailMessageTemplate."Event Result";
        EMailContent := JCAEventMailing.ReturnMailContent(tempJCAMailMessageTemplate);
        MailBody.AppendLine(EMailContent);
    end;
}
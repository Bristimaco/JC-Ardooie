codeunit 50114 "JCA Grouped Event Result Mail" implements "JCA Event Mailing"
{
    procedure EditTemplate(var JCAMailMessageTemplate: record "JCA Mail Message Template")
    var
        JCAGrEvResMailEditor: page "JCA Gr. Ev. Res. Mail Editor";
    begin
        clear(JCAGrEvResMailEditor);
        JCAGrEvResMailEditor.SetTableView(JCAMailMessageTemplate);
        JCAGrEvResMailEditor.run();
    end;

    procedure ReturnMailContent(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Text
    var
        JCAEvent: record "JCA Event";
        JCAEventParticipant: record "JCA Event Participant";
        JCASetup: Record "JCA Setup";
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        ResultCardLogo: Text;
        TemplateData: text;
        ResultsTable: TextBuilder;
        MailContent: Text;
    begin
        ResultCardLogo := '';
        JCASetup.Reset();
        JCASetup.get();
        ResultCardLogo := JCASetup.GetResultCardLogo();

        JCAEvent.Reset();
        JCAEvent.setrange("No.", tempJCAMailMessageTemplate."Event No.");
        if not JCAEvent.findfirst() then
            exit;

        clear(ResultsTable);
        ResultsTable.AppendLine('<table>');
        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Event No.", JCAEvent."No.");
        JCAEventParticipant.setrange("No-Show", false);
        if JCAEventParticipant.findset() then
            repeat
                AddResultTableRow(ResultsTable, JCAEventParticipant);
            until JCAEventParticipant.Next() = 0;
        ResultsTable.AppendLine('</table>');

        JCAMailMessageTemplate.Reset();
        JCAMailMessageTemplate.get(tempJCAMailMessageTemplate."Mail Message Type");
        JCAMailMessageTemplate.ReadTemplateData(TemplateData);
        MailContent := StrSubstNo(TemplateData, ResultCardLogo, ResultsTable.ToText());
        exit(MailContent);
    end;

    procedure SendMail(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Boolean
    var
        JCAMember: record "JCA Member";
        JCAEvent: Record "JCA Event";
        JCAContact: record "JCA Contact";
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        MailManagement: codeunit "Mail Management";
        JCAMailManagement: Codeunit "JCA Mail System Helper";
        EmailMessage: codeunit "Email Message";
        Email: codeunit Email;
        MailingList: list of [Text[100]];
        MailAddress: text[100];
        MailSubject: text;
        MailBody: TextBuilder;
    begin
        clear(MailingList);

        JCAEvent.Reset();
        JCAEvent.get(tempJCAMailMessageTemplate."Event No.");

        JCAMailMessageTemplate.reset();
        if JCAMailMessageTemplate.get(enum::"JCA Mail Message Type"::"Grouped Event Result") then
            JCAMailMessageTemplate.CalcFields("Mail Template Data");

        JCAMember.Reset();
        JCAMember.setrange("Send Grouped Result Mails", true);
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

        CreateGroupedEventResultMailContent(JCAEvent, MailSubject, MailBody);
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

    local procedure CreateGroupedEventResultMailContent(JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder)
    var
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary;
        JCAEventMailing: Interface "JCA Event Mailing";
        EMailContent: Text;
        ResultsLbl: label 'Results for %1 %2', Comment = '%1 = Event No., %2 = Event Description';
    begin
        MailSubject := StrSubstNo(ResultsLbl, JCAEvent.Type, JCAEvent.Description);

        Clear(MailBody);
        JCAMailMessageTemplate.reset();
        JCAMailMessageTemplate.get(enum::"JCA Mail Message Type"::"Grouped Event Result");
        JCAEventMailing := JCAMailMessageTemplate."Mail Message Type";
        tempJCAMailMessageTemplate."Mail Message Type" := JCAMailMessageTemplate."Mail Message Type";
        tempJCAMailMessageTemplate."Event No." := JCAEvent."No.";
        EMailContent := JCAEventMailing.ReturnMailContent(tempJCAMailMessageTemplate);
        MailBody.AppendLine(EMailContent);
    end;


    local procedure AddResultTableRow(var ResultsTable: TextBuilder; JCAEventParticipant: record "JCA Event Participant")
    var
        JCAMember: record "JCA Member";
    begin
        ResultsTable.AppendLine('<tr>');
        JCAMember.Reset();
        JCAMember.get(JCAEventParticipant."Member License ID");

        ResultsTable.AppendLine('<td>');
        ResultsTable.AppendLine(JCAMember."Full Name");
        ResultsTable.AppendLine('</td>');

        ResultsTable.AppendLine('<td>');
        ResultsTable.AppendLine(JCAEventParticipant."Age Group Code");
        ResultsTable.AppendLine('</td>');

        ResultsTable.AppendLine('<td>');
        ResultsTable.AppendLine(format(JCAEventParticipant.Result));
        ResultsTable.AppendLine('</td>');

        ResultsTable.AppendLine('</tr>');
    end;
}
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

    procedure SendMail(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Boolean
    var
        JCAMember: Record "JCA Member";
        JCAEvent: Record "JCA Event";
        JCAEventDocument: record "JCA Event Document";
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        MailManagement: codeunit "Mail Management";
        EmailMessage: codeunit "Email Message";
        JCAActionLogManagement: codeunit "JCA Action Log Management";
        JCAMailManagement: codeunit "JCA Mail System Helper";
        Email: codeunit Email;
        InStream: InStream;
        SendToMail: text[100];
        SendToCCList: list of [Text[100]];
        MailBody: TextBuilder;
        MailSubject: Text;
        AttachmentName: Text[250];
        CCEMail: text[100];
        MailSent: Boolean;
        HasError: Boolean;
        UseTemplate: Boolean;
        LogDescription: text;
        InvitationMailSentLbl: Label 'An invitation for Event %1 - %2 has been sent to %3 - %4', comment = '%1 = Event No., %2 = Event Description, %3 = License ID, %4 = Member Name';
        InvitationMailFailedLbl: Label 'Failed to send an invitation for Event %1 - %2 to %3 - %4', comment = '%1 = Event No., %2 = Event Description, %3 = License ID, %4 = Member Name';
    begin
        HasError := false;
        MailSent := false;

        JCAMember.Reset();
        JCAMember.get(tempJCAMailMessageTemplate."Member License ID");
        if JCAMember."E-Mail" = '' then
            HasError := true;

        if not HasError then begin
            SendToMail := JCAMember."E-Mail";
            JCAMailManagement.CheckForMailSystemTest(SendToMail);

            clear(MailManagement);
            if not MailManagement.CheckValidEmailAddress(SendToMail) then
                HasError := true;

            UseTemplate := false;
            JCAMailMessageTemplate.reset();
            if JCAMailMessageTemplate.get(enum::"JCA Mail Message Type"::"Event Result") then begin
                JCAMailMessageTemplate.CalcFields("Mail Template Data");
                if JCAMailMessageTemplate."Mail Template Data".HasValue() then
                    UseTemplate := true;
            end;

            JCAEvent.reset();
            JCAEvent.get(tempJCAMailMessageTemplate."Event No.");

            if not HasError then begin
                JCAMailManagement.CollectCCMAilAddresses(JCAMember, SendToCCList);

                CreateEventInvitationMailContent(JCAMember, JCAEvent, MailSubject, MailBody, JCAEventDocument, UseTemplate);

                clear(EmailMessage);
                EmailMessage.Create(SendToMail, MailSubject, MailBody.ToText(), true);
                foreach CCEmail in SendToCCList do
                    EmailMessage.AddRecipient(enum::"Email Recipient Type"::Cc, CCEMail);

                if JCAEventDocument.findset() then
                    repeat
                        AttachmentName := JCAEventDocument."Event No." + '-' + format(JCAEventDocument."Document No.") + '.' + JCAEventDocument.Extension;
                        JCAEventDocument.CalcFields("Document Content");
                        JCAEventDocument."Document Content".CreateInStream(InStream);
                        EMailMessage.AddAttachment(AttachmentName, JCAEventDocument.Extension, InStream);
                    until JCAEventDocument.Next() = 0;


                clear(Email);
                MailSent := Email.Send(EmailMessage, enum::"Email Scenario"::Default);
            end;
        end;

        clear(JCAActionLogManagement);
        if MailSent then
            LogDescription := StrSubstNo(InvitationMailSentLbl, JCAEvent."No.", JCAEvent.Description, JCAMember."License ID", JCAMember."Full Name")
        else
            LogDescription := StrSubstNo(InvitationMailFailedLbl, JCAEvent."No.", JCAEvent.Description, JCAMember."License ID", JCAMember."Full Name");
        JCAActionLogManagement.LogApplicatonAction(enum::"JCA Application Action"::"Event Invitation Mail", copystr(LogDescription, 1, 250), JCAMember, JCAEvent);

        exit(MailSent);
    end;

    local procedure CreateEventInvitationMailContent(JCAMember: record "JCA Member"; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder; var JCAEventDocument: record "JCA Event Document"; UseTemplate: Boolean)
    var
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary;
        JCAEventMailing: Interface JCAEventMailing;
        EmailContent: Text;
        InvitationSubjectLbl: label 'Invitation for %1 - %2', Comment = '%1 = Event No., %2 = Event Description';
    begin
        MailSubject := StrSubstNo(InvitationSubjectLbl, JCAEvent.Type, JCAEvent.Description);

        UseTemplate := false;
        JCAMailMessageTemplate.reset();
        if JCAMailMessageTemplate.get(enum::"JCA Mail Message Type"::Invitation) then begin
            JCAMailMessageTemplate.CalcFields("Mail Template Data");
            if JCAMailMessageTemplate."Mail Template Data".HasValue() then
                UseTemplate := true;
        end;

        Clear(MailBody);
        if UseTemplate then begin
            JCAMailMessageTemplate.reset();
            JCAMailMessageTemplate.get(enum::"JCA Mail Message Type"::Invitation);
            JCAEventMailing := JCAMailMessageTemplate."Mail Message Type";
            tempJCAMailMessageTemplate.reset();
            tempJCAMailMessageTemplate.init();
            tempJCAMailMessageTemplate."Mail Message Type" := JCAMailMessageTemplate."Mail Message Type";
            tempJCAMailMessageTemplate."Member License ID" := JCAMember."License ID";
            tempJCAMailMessageTemplate."Event No." := JCAEvent."No.";
            EmailContent := JCAEventMailing.ReturnMailContent(tempJCAMailMessageTemplate);
            MailBody.AppendLine(EmailContent);
        end else begin
            Clear(MailBody);
            MailBody.AppendLine('Beste ' + JCAMember."First Name" + ',');
            MailBody.AppendLine();
            MailBody.AppendLine('Op ' + format(JCAEvent.Date) + ' gaat het ' + format(JCAEvent.type) + ' - ' + JCAEvent.Description + ' door');
            MailBody.AppendLine();
            MailBody.AppendLine('U wordt hierbij uitgenodigd om u in te schrijven tegen ' + format(JCAEvent."Registration Deadline"));
            MailBody.AppendLine();
            MailBody.AppendLine('Dit evenement gaat door op het volgende adres:');
            MailBody.AppendLine(JCAEvent.Address);
            MailBody.AppendLine(JCAEvent."Post Code" + ' ' + JCAEvent.City);
            MailBody.AppendLine();
            MailBody.AppendLine('Indien u wenst deel te nemen, graag een seintje');
            MailBody.AppendLine();
            MailBody.AppendLine('Met vriendelijke groeten,');
            MailBody.AppendLine();
            MailBody.AppendLine('Judo Ardooie');
        end;
        CollectEventAttachments(JCAEvent, JCAEventDocument);
    end;

    local procedure CollectEventAttachments(JCAEvent: record "JCA Event"; var JCAEventDocument: record "JCA Event Document")
    begin
        JCAEventDocument.Reset();
        JCAEventDocument.setrange("Event No.", JCAEvent."No.");
        JCAEventDocument.setrange("Add in Mails", true);
    end;
}
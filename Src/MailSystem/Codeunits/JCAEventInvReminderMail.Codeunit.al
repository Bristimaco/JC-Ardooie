codeunit 50111 "JCA Event Inv. Reminder Mail" implements "JCA Event Mailing"
{
    procedure EditTemplate(var JCAMailMessageTemplate: record "JCA Mail Message Template")
    begin
    end;

    procedure ReturnMailContent(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Text
    var
    begin
    end;

    procedure SendMail(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Boolean
    var
        JCAMember: Record "JCA Member";
        JCAEventDocument: record "JCA Event Document";
        JCAEvent: Record "JCA Event";
        MailManagement: codeunit "Mail Management";
        JCAMailManagement: codeunit "JCA Mail System Helper";
        EmailMessage: codeunit "Email Message";
        JCAActionLogManagement: codeunit "JCA Action Log Management";
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
        LogDescription: text;
    begin
        HasError := false;
        MailSent := false;

        JCAEvent.Reset();
        JCAEvent.get(tempJCAMailMessageTemplate."Event No.");

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

            if not HasError then begin
                JCAMailManagement.CollectCCMAilAddresses(JCAMember, SendToCCList);

                CreateEventReminderMailContent(JCAMember, JCAEvent, MailSubject, MailBody, JCAEventDocument);

                clear(EmailMessage);
                EmailMessage.Create(SendToMail, MailSubject, MailBody.ToText());
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
        JCAActionLogManagement.LogApplicatonAction(enum::"JCA Application Action"::"Event Reminder Mail", copystr(LogDescription, 1, 250), JCAMember, JCAEvent);
        exit(MailSent);
    end;

    local procedure CreateEventReminderMailContent(JCAMember: record "JCA Member"; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder; var JCAEventDocument: record "JCA Event Document")
    var
        JCAEventParticipant: record "JCA Event Participant";
        JCAEventSupervisor: record "JCA Event Supervisor";
        InvitationSubjectLbl: label 'Invitation Reminder for %1 - %2', Comment = '%1 = Event No., %2 = Event Description';
    begin
        MailSubject := StrSubstNo(InvitationSubjectLbl, JCAEvent.Type, JCAEvent.Description);

        Clear(MailBody);
        MailBody.AppendLine('Beste ' + JCAMember."First Name" + ',');
        MailBody.AppendLine();
        MailBody.AppendLine('Op ' + format(JCAEvent.Date) + ' gaat het ' + format(JCAEvent.type) + ' - ' + JCAEvent.Description + ' door');
        MailBody.AppendLine();
        MailBody.AppendLine('Wij hebben nog geen aanvraag tot inschrijving van u ontvangen.');
        MailBody.AppendLine('U kunt nog inschrijven tot ' + format(JCAEvent."Registration Deadline"));
        MailBody.AppendLine();
        MailBody.AppendLine('Dit evenement gaat door op het volgende adres:');
        MailBody.AppendLine(JCAEvent.Address);
        MailBody.AppendLine(JCAEvent."Post Code" + ' ' + JCAEvent.City);
        MailBody.AppendLine();
        MailBody.AppendLine('De volgende JCA leden hebben zich reeds ingeschreen:');

        JCAEventSupervisor.Reset();
        JCAEventSupervisor.setrange("Event No.", JCAEvent."No.");
        JCAEventSupervisor.setrange("Applied for Registration", true);
        if JCAEventSupervisor.findset() then
            repeat
                MailBody.AppendLine();
                JCAEventSupervisor.calcfields("Member Full Name");
                MailBody.AppendLine(JCAEventSupervisor."Member Full Name");
            until JCAEventSupervisor.Next() = 0;

        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Event No.", JCAEvent."No.");
        JCAEventParticipant.setrange("Applied for Registration", true);
        if JCAEventParticipant.findset() then
            repeat
                MailBody.AppendLine();
                JCAEventParticipant.calcfields("Member Full Name");
                MailBody.AppendLine(JCAEventParticipant."Member Full Name" + ' - Categorie: ' + JCAEventParticipant."Weight Group Code");
            until JCAEventParticipant.Next() = 0;

        MailBody.AppendLine();
        MailBody.AppendLine('Indien u alsnog wenst deel te nemen, graag een seintje');
        MailBody.AppendLine();
        MailBody.AppendLine('Met vriendelijke groeten,');
        MailBody.AppendLine();
        MailBody.AppendLine('Judo Ardooie');

        CollectEventAttachments(JCAEvent, JCAEventDocument);
    end;

    local procedure CollectEventAttachments(JCAEvent: record "JCA Event"; var JCAEventDocument: record "JCA Event Document")
    begin
        JCAEventDocument.Reset();
        JCAEventDocument.setrange("Event No.", JCAEvent."No.");
        JCAEventDocument.setrange("Add in Mails", true);
    end;
}
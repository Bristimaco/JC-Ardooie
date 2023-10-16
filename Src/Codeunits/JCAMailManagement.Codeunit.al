codeunit 50104 "JCA Mail Management"
{
    procedure SendEventResultMail(JCAEventParticipant: record "JCA Event Participant")
    var
        JCAEvent: record "JCA Event";
        JCAMember: record "JCA Member";
        JCAContact: record "JCA Contact";
        MailManagement: codeunit "Mail Management";
        EmailMessage: codeunit "Email Message";
        Email: codeunit Email;
        MailingList: list of [Text[100]];
        MailAddress: text[100];
        MailSubject: text;
        MailBody: TextBuilder;
    begin
        JCAEvent.reset();
        JCAEvent.get(JCAEventParticipant."Event No.");
        if not JCAEvent."Send Result Mails" then
            exit;

        clear(MailingList);

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

        foreach MailAddress in MailingList do begin
            CheckForMailSystemTest(MailAddress);
            clear(MailManagement);
            if MailManagement.CheckValidEmailAddress(MailAddress) then begin
                CreateEventResultMailContent(JCAEventParticipant, JCAEvent, MailSubject, MailBody);
                clear(EmailMessage);
                EmailMessage.Create(MailAddress, MailSubject, MailBody.ToText());
                clear(Email);
                Email.Send(EmailMessage, enum::"Email Scenario"::Default);
            end;
        end;
    end;

    procedure SendEventInvitationMail(MemberLicenseID: code[20]; JCAEvent: record "JCA Event"): Boolean
    var
        JCAMember: Record "JCA Member";
        JCAEventDocument: record "JCA Event Document";
        MailManagement: codeunit "Mail Management";
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
        InvitationMailSentLbl: Label 'An invitation for Event %1 - %2 has been sent to %3 - %4';
        InvitationMailFailedLbl: Label 'Failed to send an invitation for Event %1 - %2 to %3 - %4';
    begin
        HasError := false;
        MailSent := false;

        JCAMember.Reset();
        JCAMember.get(MemberLicenseID);
        if JCAMember."E-Mail" = '' then
            HasError := true;

        if not HasError then begin
            SendToMail := JCAMember."E-Mail";
            CheckForMailSystemTest(SendToMail);

            clear(MailManagement);
            if not MailManagement.CheckValidEmailAddress(SendToMail) then
                HasError := true;

            if not HasError then begin
                CollectCCMAilAddresses(JCAMember, SendToCCList);

                CreateEventInvitationMailContent(JCAMember, JCAEvent, MailSubject, MailBody, JCAEventDocument);

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
        if MailSent then
            LogDescription := StrSubstNo(InvitationMailSentLbl, JCAEvent."No.", JCAEvent.Description, JCAMember."License ID", JCAMember."Full Name")
        else
            LogDescription := StrSubstNo(InvitationMailFailedLbl, JCAEvent."No.", JCAEvent.Description, JCAMember."License ID", JCAMember."Full Name");
        JCAActionLogManagement.LogApplicatonAction(enum::"JCA Application Action"::"Event Invitation Mail", LogDescription, JCAMember, JCAEvent);

        exit(MailSent);
    end;

    procedure SendRegistrationConfirmationMail(MemberLicenseID: code[20]; JCAEvent: record "JCA Event"): Boolean
    var
        JCAMember: Record "JCA Member";
        JCAEventDocument: record "JCA Event Document";
        MailManagement: codeunit "Mail Management";
        EmailMessage: codeunit "Email Message";
        JCAActionLogManagement: codeunit "JCA Action Log Management";
        Email: codeunit Email;
        SendToMail: text[100];
        SendToCCList: list of [Text[100]];
        MailBody: TextBuilder;
        MailSubject: Text;
        CCEMail: text[100];
        MailSent: Boolean;
        HasError: Boolean;
        LogDescription: text;
        RegistrationConfirmationMailSentLbl: Label 'A Registration Confirmation for Event %1 - %2 has been sent to %3 - %4';
        RegistrationConfirmationMailFailedLbl: Label 'Failed to send a Registration Confirmation for Event %1 - %2 to %3 - %4';
    begin
        HasError := false;
        MailSent := false;

        JCAMember.Reset();
        JCAMember.get(MemberLicenseID);
        if JCAMember."E-Mail" = '' then
            HasError := true;

        if not HasError then begin
            SendToMail := JCAMember."E-Mail";
            CheckForMailSystemTest(SendToMail);

            clear(MailManagement);
            if not MailManagement.CheckValidEmailAddress(SendToMail) then
                HasError := true;

            if not HasError then begin
                CollectCCMAilAddresses(JCAMember, SendToCCList);

                CreateEventRegistrationConfirmationMailContent(JCAMember, JCAEvent, MailSubject, MailBody, JCAEventDocument);

                clear(EmailMessage);
                EmailMessage.Create(SendToMail, MailSubject, MailBody.ToText());
                foreach CCEmail in SendToCCList do
                    EmailMessage.AddRecipient(enum::"Email Recipient Type"::Cc, CCEMail);

                clear(Email);
                MailSent := Email.Send(EmailMessage, enum::"Email Scenario"::Default);
            end;
        end;

        clear(JCAActionLogManagement);
        if MailSent then
            LogDescription := StrSubstNo(RegistrationConfirmationMailSentLbl, JCAEvent."No.", JCAEvent.Description, JCAMember."License ID", JCAMember."Full Name")
        else
            LogDescription := StrSubstNo(RegistrationConfirmationMailFailedLbl, JCAEvent."No.", JCAEvent.Description, JCAMember."License ID", JCAMember."Full Name");
        JCAActionLogManagement.LogApplicatonAction(enum::"JCA Application Action"::"Event Registration Confirmation Mail", LogDescription, JCAMember, JCAEvent);

        exit(MailSent);
    end;

    procedure SendUnRegistrationConfirmationMail(MemberLicenseID: code[20]; JCAEvent: record "JCA Event"): Boolean
    var
        JCAMember: Record "JCA Member";
        JCAEventDocument: record "JCA Event Document";
        MailManagement: codeunit "Mail Management";
        EmailMessage: codeunit "Email Message";
        JCAActionLogManagement: codeunit "JCA Action Log Management";
        Email: codeunit Email;
        SendToMail: text[100];
        SendToCCList: list of [Text[100]];
        MailBody: TextBuilder;
        MailSubject: Text;
        CCEMail: text[100];
        MailSent: Boolean;
        HasError: Boolean;
        LogDescription: text;
        UnRegistrationConfirmationMailSentLbl: Label 'An Unregistration Confirmation for Event %1 - %2 has been sent to %3 - %4';
        UnRegistrationConfirmationMailFailedLbl: Label 'Failed to send an Unregistration Confirmation for Event %1 - %2 to %3 - %4';
    begin
        HasError := false;
        MailSent := false;

        JCAMember.Reset();
        JCAMember.get(MemberLicenseID);
        if JCAMember."E-Mail" = '' then
            HasError := true;

        if not HasError then begin
            SendToMail := JCAMember."E-Mail";
            CheckForMailSystemTest(SendToMail);

            clear(MailManagement);
            if not MailManagement.CheckValidEmailAddress(SendToMail) then
                HasError := true;

            if not HasError then begin
                CollectCCMAilAddresses(JCAMember, SendToCCList);

                CreateEventUnRegistrationConfirmationMailContent(JCAMember, JCAEvent, MailSubject, MailBody, JCAEventDocument);

                clear(EmailMessage);
                EmailMessage.Create(SendToMail, MailSubject, MailBody.ToText());
                foreach CCEmail in SendToCCList do
                    EmailMessage.AddRecipient(enum::"Email Recipient Type"::Cc, CCEMail);

                clear(Email);
                MailSent := Email.Send(EmailMessage, enum::"Email Scenario"::Default);
            end;
        end;

        clear(JCAActionLogManagement);
        if MailSent then
            LogDescription := StrSubstNo(UnRegistrationConfirmationMailSentLbl, JCAEvent."No.", JCAEvent.Description, JCAMember."License ID", JCAMember."Full Name")
        else
            LogDescription := StrSubstNo(UnRegistrationConfirmationMailFailedLbl, JCAEvent."No.", JCAEvent.Description, JCAMember."License ID", JCAMember."Full Name");
        JCAActionLogManagement.LogApplicatonAction(enum::"JCA Application Action"::"Event Unregistration Confirmation Mail", LogDescription, JCAMember, JCAEvent);

        exit(MailSent);
    end;

    local procedure CheckForMailSystemTest(var SendToMail: text[100])
    var
        JCASetup: Record "JCA Setup";
    begin
        JCASetup.Reset();
        JCASetup.get();
        if JCASetup."Send Test Mails" then begin
            JCASetup.TestField("Test E-Mail Address");
            SendToMail := JCASetup."Test E-Mail Address";
        end;
    end;

    local procedure CollectCCMAilAddresses(JCAMember: Record "JCA Member"; var SendToCCList: list of [text[100]])
    var
        JCAMemberContact: Record "JCA Member Contact";
        MailManagement: codeunit "Mail Management";
        CCMailAddress: Text[100];
    begin
        clear(SendToCCList);
        JCAMemberContact.Reset();
        JCAMemberContact.SetRange("Member License ID", JCAMember."License ID");
        if JCAMemberContact.findset() then
            repeat
                JCAMemberContact.CalcFields("Contact E-Mail");
                clear(MailManagement);
                if MailManagement.CheckValidEmailAddress(JCAMemberContact."Contact E-Mail") then begin
                    CCMailAddress := JCAMemberContact."Contact E-Mail";
                    CheckForMailSystemTest(CCMailAddress);
                    if not SendToCCList.Contains(CCMailAddress) then
                        SendToCCList.Add(CCMailAddress);
                end;
            until JCAMemberContact.Next() = 0;
    end;

    local procedure CreateEventInvitationMailContent(JCAMember: record "JCA Member"; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder; var JCAEventDocument: record "JCA Event Document")
    var
        InvitationSubjectLbl: label 'Invitation for %1 - %2';
    begin
        MailSubject := StrSubstNo(InvitationSubjectLbl, JCAEvent.Type, JCAEvent.Description);

        Clear(MailBody);
        MailBody.AppendLine('Beste ' + JCAMember."First Name" + ',');
        MailBody.AppendLine();
        MailBody.AppendLine('Op ' + format(JCAEvent.Date) + ' gaat het ' + format(JCAEvent.type) + ' - ' + JCAEvent.Description + ' door');
        MailBody.AppendLine();
        MailBody.AppendLine('U wordt hierbij uitgenodigd om u in te schrijven tegen ' + format(JCAEvent."Registration Deadline"));
        MailBody.AppendLine();
        MailBody.AppendLine('Indien u wenst deel te nemen, graag een seintje');
        MailBody.AppendLine();
        MailBody.AppendLine('Met vriendelijke groeten,');
        MailBody.AppendLine();
        MailBody.AppendLine('Judo Ardooie');

        CollectEventAttachments(JCAEvent, JCAEventDocument);
    end;

    local procedure CreateEventRegistrationConfirmationMailContent(JCAMember: record "JCA Member"; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder; var JCAEventDocument: record "JCA Event Document")
    var
        RegistrationConfirmationSubjectLbl: label 'Registration Confirmation for %1 - %2';
    begin
        MailSubject := StrSubstNo(RegistrationConfirmationSubjectLbl, JCAEvent.Type, JCAEvent.Description);

        Clear(MailBody);
        MailBody.AppendLine('Beste ' + JCAMember."First Name" + ',');
        MailBody.AppendLine();
        MailBody.AppendLine('Hierbij bevestiging dat u bent ingeschreven voor het volgende evenement: ' + format(JCAEvent.Type) + ' - ' + JCAEvent.Description);
        MailBody.AppendLine('Dit gaat door op ' + format(JCAEvent.Date));
        MailBody.AppendLine();
        MailBody.AppendLine('Indien u deze inschrijving wil annuleren, gelieve dit zo snel mogelijk te laten weten');
        MailBody.AppendLine();
        MailBody.AppendLine('Met vriendelijke groeten,');
        MailBody.AppendLine();
        MailBody.AppendLine('Judo Ardooie');
    end;

    local procedure CreateEventUnregistrationConfirmationMailContent(JCAMember: record "JCA Member"; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder; var JCAEventDocument: record "JCA Event Document")
    var
        UnregistrationConfirmationLbl: label 'Unregistration Confirmation for %1 - %2';
    begin
        MailSubject := StrSubstNo(UnregistrationConfirmationLbl, JCAEvent.Type, JCAEvent.Description);

        Clear(MailBody);
        MailBody.AppendLine('Beste ' + JCAMember."First Name" + ',');
        MailBody.AppendLine();
        MailBody.AppendLine('Hierbij bevestiging dat u niet langer bent ingeschreven voor het volgende evenement: ' + format(JCAEvent.Type) + ' - ' + JCAEvent.Description);
        MailBody.AppendLine();
        MailBody.AppendLine('Met vriendelijke groeten,');
        MailBody.AppendLine();
        MailBody.AppendLine('Judo Ardooie');
    end;

    local procedure CreateEventResultMailContent(JCAEventParticipant: record "JCA Event Participant"; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder)
    var
        ResultsLbl: label 'Results for %1 - %2: %3';
    begin
        MailSubject := StrSubstNo(ResultsLbl, JCAEvent.Type, JCAEvent.Description, JCAEventParticipant."Member Full Name");

        Clear(MailBody);
        MailBody.AppendLine('Beste suporter,');
        MailBody.AppendLine();
        MailBody.AppendLine('Tijdens het ' + format(JCAEvent.Type) + ' - ' + JCAEvent.Description + ' behaalde ' + JCAEventParticipant."Member Full Name" + ' het volgende resulaat:');
        MailBody.AppendLine();
        MailBody.AppendLine(UpperCase(format(JCAEventParticipant.Result)));
        MailBody.AppendLine();
        MailBody.AppendLine('Met vriendelijke groeten,');
        MailBody.AppendLine();
        MailBody.AppendLine('Judo Ardooie');
    end;

    local procedure CollectEventAttachments(JCAEvent: record "JCA Event"; var JCAEventDocument: record "JCA Event Document")
    begin
        JCAEventDocument.Reset();
        JCAEventDocument.setrange("Event No.", JCAEvent."No.");
        JCAEventDocument.setrange("Add in Mails", true);
    end;
}
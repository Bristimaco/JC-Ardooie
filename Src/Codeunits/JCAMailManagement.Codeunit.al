codeunit 50104 "JCA Mail Management"
{
    procedure SendEventResultMail(JCAEventParticipant: record "JCA Event Participant")
    var
        JCAEvent: record "JCA Event";
        JCAMember: record "JCA Member";
        JCAContact: record "JCA Contact";
        TenantMedia: record "Tenant Media";
        JCAResultImage: Record "JCA Result Image";
        MailManagement: codeunit "Mail Management";
        EmailMessage: codeunit "Email Message";
        Base64Convert: Codeunit "Base64 Convert";
        Email: codeunit Email;
        MailingList: list of [Text[100]];
        MailAddress: text[100];
        MailSubject: text;
        MemberPicture: Text;
        ResultImage: Text;
        InStream: InStream;
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

        MemberPicture := '';
        JCAMember.Reset();
        JCAMember.get(JCAEventParticipant."Member License ID");
        if JCAMember.Picture.Count() <> 0 then begin
            TenantMedia.reset();
            TenantMedia.get(JCAMember.Picture.Item(1));
            TenantMedia.CalcFields(Content);
            TenantMedia.Content.CreateInStream(InStream);
            MemberPicture := Base64Convert.ToBase64(InStream);
        end;

        ResultImage := '';
        JCAResultImage.Reset();
        JCAResultImage.setrange(Result, JCAEventParticipant.Result);
        JCAResultImage.findfirst();
        if JCAResultImage."Result Image".Count() <> 0 then begin
            TenantMedia.reset();
            TenantMedia.get(JCAResultImage."Result Image".item(1));
            TenantMedia.CalcFields(Content);
            TenantMedia.Content.CreateInStream(InStream);
            ResultImage := Base64Convert.ToBase64(InStream);
        end;

        foreach MailAddress in MailingList do begin
            CheckForMailSystemTest(MailAddress);
            clear(MailManagement);
            if MailManagement.CheckValidEmailAddress(MailAddress) then begin
                CreateEventResultMailContent(JCAEventParticipant, JCAEvent, MailSubject, MailBody, MemberPicture, ResultImage);
                clear(EmailMessage);
                EmailMessage.Create(MailAddress, MailSubject, MailBody.ToText(), true);
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
        InvitationMailSentLbl: Label 'An invitation for Event %1 - %2 has been sent to %3 - %4', comment = '%1 = Event No., %2 = Event Description, %3 = License ID, %4 = Member Name';
        InvitationMailFailedLbl: Label 'Failed to send an invitation for Event %1 - %2 to %3 - %4', comment = '%1 = Event No., %2 = Event Description, %3 = License ID, %4 = Member Name';
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
        JCAActionLogManagement.LogApplicatonAction(enum::"JCA Application Action"::"Event Invitation Mail", copystr(LogDescription, 1, 250), JCAMember, JCAEvent);

        exit(MailSent);
    end;

    procedure SendEventReminderMail(MemberLicenseID: code[20]; JCAEvent: record "JCA Event"): Boolean
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

    procedure SendRegistrationConfirmationMail(JCAEventParticipant: record "JCA Event Participant"; JCAEvent: record "JCA Event"): Boolean
    begin
        exit(doSendRegistrationConfirmationMail(JCAEventParticipant."Member License ID", JCAEventParticipant."Weight Group Code", JCAEvent));
    end;

    procedure SendRegistrationConfirmationMail(JCAEventSupervisor: record "JCA Event Supervisor"; JCAEvent: record "JCA Event"): Boolean
    begin
        exit(doSendRegistrationConfirmationMail(JCAEventSupervisor."Member License ID", '', JCAEvent));
    end;

    procedure doSendRegistrationConfirmationMail(MemberLicenseID: code[20]; WeightGroupCode: code[20]; JCAEvent: record "JCA Event"): Boolean;
    var
        JCAMember: Record "JCA Member";
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
        RegistrationConfirmationMailSentLbl: Label 'A Registration Confirmation for Event %1 - %2 has been sent to %3 - %4', comment = '%1 = Event No., %2 = Event Description, %3 = License ID, %4 = Member Name';
        RegistrationConfirmationMailFailedLbl: Label 'Failed to send a Registration Confirmation for Event %1 - %2 to %3 - %4', comment = '%1 = Event No., %2 = Event Description, %3 = License ID, %4 = Member Name';
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

                CreateEventRegistrationConfirmationMailContent(MemberLicenseID, WeightGroupCode, JCAEvent, MailSubject, MailBody);

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
        JCAActionLogManagement.LogApplicatonAction(enum::"JCA Application Action"::"Event Registration Confirmation Mail", copystr(LogDescription, 1, 250), JCAMember, JCAEvent);

        exit(MailSent);
    end;

    procedure SendUnregistrationConfirmationMail(JCAEventParticipant: record "JCA Event Participant"; JCAEvent: record "JCA Event"): Boolean
    begin
        exit(doSendUnRegistrationConfirmationMail(JCAEventParticipant."Member License ID", JCAEventParticipant."Weight Group Code", JCAEvent));
    end;

    procedure SendUnregistrationConfirmationMail(JCAEventSupervisor: record "JCA Event Supervisor"; JCAEvent: record "JCA Event"): Boolean
    begin
        exit(doSendUnRegistrationConfirmationMail(JCAEventSupervisor."Member License ID", '', JCAEvent));
    end;

    procedure doSendUnRegistrationConfirmationMail(MemberLicenseID: code[20]; WeightGroupCode: Code[20]; JCAEvent: record "JCA Event"): Boolean
    var
        JCAMember: Record "JCA Member";
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
        UnRegistrationConfirmationMailSentLbl: Label 'An Unregistration Confirmation for Event %1 - %2 has been sent to %3 - %4', comment = '%1 = Event No., %2 = Event Description, %3 = License ID, %4 = Member Name';
        UnRegistrationConfirmationMailFailedLbl: Label 'Failed to send an Unregistration Confirmation for Event %1 - %2 to %3 - %4', comment = '%1 = Event No., %2 = Event Description, %3 = License ID, %4 = Member Name';
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

                CreateEventUnRegistrationConfirmationMailContent(MemberLicenseID, WeightGroupCode, JCAEvent, MailSubject, MailBody);

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
        JCAActionLogManagement.LogApplicatonAction(enum::"JCA Application Action"::"Event Unregistration Confirmation Mail", copystr(LogDescription, 1, 250), JCAMember, JCAEvent);

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
        InvitationSubjectLbl: label 'Invitation for %1 - %2', Comment = '%1 = Event No., %2 = Event Description';
    begin
        MailSubject := StrSubstNo(InvitationSubjectLbl, JCAEvent.Type, JCAEvent.Description);

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

        CollectEventAttachments(JCAEvent, JCAEventDocument);
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

    local procedure CreateEventRegistrationConfirmationMailContent(LicenseID: code[20]; WeightGroupCode: code[20]; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder)
    var
        JCAMember: Record "JCA Member";
        RegistrationConfirmationSubjectLbl: label 'Registration Confirmation for %1 - %2', Comment = '%1 = Event No., %2 = Event Description';
    begin
        MailSubject := StrSubstNo(RegistrationConfirmationSubjectLbl, JCAEvent.Type, JCAEvent.Description);

        JCAMember.Reset();
        JCAMember.get(LicenseID);

        Clear(MailBody);
        MailBody.AppendLine('Beste ' + JCAMember."First Name" + ',');
        MailBody.AppendLine();
        if WeightGroupCode <> '' then
            MailBody.AppendLine('Hierbij bevestiging dat u bent ingeschreven voor het volgende evenement: ' + format(JCAEvent.Type) + ' - ' + JCAEvent.Description + ' Categorie: ' + WeightGroupCode)
        else
            MailBody.AppendLine('Hierbij bevestiging dat u bent ingeschreven voor het volgende evenement: ' + format(JCAEvent.Type) + ' - ' + JCAEvent.Description);
        MailBody.AppendLine('Dit gaat door op ' + format(JCAEvent.Date));
        MailBody.AppendLine();
        MailBody.AppendLine('Indien u deze inschrijving wil annuleren, gelieve dit zo snel mogelijk te laten weten');
        MailBody.AppendLine();
        MailBody.AppendLine('Met vriendelijke groeten,');
        MailBody.AppendLine();
        MailBody.AppendLine('Judo Ardooie');
    end;

    local procedure CreateEventUnregistrationConfirmationMailContent(LicenseID: Code[20]; WeightGroupCode: Code[20]; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder)
    var
        JCAMember: record "JCA Member";
        UnregistrationConfirmationLbl: label 'Unregistration Confirmation for %1 - %2', Comment = '%1 = Event No., %2 = Event Description';
    begin
        MailSubject := StrSubstNo(UnregistrationConfirmationLbl, JCAEvent.Type, JCAEvent.Description);

        JCAMember.Reset();
        JCAMember.get(LicenseID);

        Clear(MailBody);
        MailBody.AppendLine('Beste ' + JCAMember."First Name" + ',');
        MailBody.AppendLine();
        if WeightGroupCode <> '' then
            MailBody.AppendLine('Hierbij bevestiging dat u niet langer bent ingeschreven voor het volgende evenement: ' + format(JCAEvent.Type) + ' Categorie: ' + JCAEvent.Description + ' - ' + WeightGroupCode)
        else
            MailBody.AppendLine('Hierbij bevestiging dat u niet langer bent ingeschreven voor het volgende evenement: ' + format(JCAEvent.Type) + ' - ' + JCAEvent.Description);
        MailBody.AppendLine();
        MailBody.AppendLine('Met vriendelijke groeten,');
        MailBody.AppendLine();
        MailBody.AppendLine('Judo Ardooie');
    end;

    local procedure CreateEventResultMailContent(JCAEventParticipant: record "JCA Event Participant"; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder; MemberPicture: Text; ResultImage: Text)
    var
        ResultsLbl: label 'Results for %1 - %2: %3', Comment = '%1 = Event No., %2 = Event Description, %3 = Member Name';
    begin
        MailSubject := StrSubstNo(ResultsLbl, JCAEvent.Type, JCAEvent.Description, JCAEventParticipant."Member Full Name");

        Clear(MailBody);
        // MailBody.AppendLine('Beste Supporter,');
        // MailBody.AppendLine();
        // MailBody.AppendLine('Tijdens het ' + format(JCAEvent.Type) + ' - ' + JCAEvent.Description + ' behaalde ' + JCAEventParticipant."Member Full Name" + ' het volgende resulaat:');
        // MailBody.AppendLine();
        // MailBody.AppendLine(UpperCase(format(JCAEventParticipant.Result)));
        // MailBody.AppendLine();
        // MailBody.AppendLine('Met vriendelijke groeten,');
        // MailBody.AppendLine();
        // MailBody.AppendLine('Judo Ardooie');


        MailBody.AppendLine('<html><head><style>card {box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);transition: 0.3s;border-radius: 5px;}');
        MailBody.AppendLine('img {border-radius: 5px 5px 0 0;}</style></head>');
        MailBody.AppendLine('<div class="card"><img id="base64image" src="data:image/jpeg;base64,');
        MailBody.AppendLine(MemberPicture);
        MailBody.AppendLine('" style="width:50%"></img><div class="container"><h4><b>');
        MailBody.AppendLine(JCAEventParticipant."Member Full Name");
        MailBody.AppendLine('</b></h4><p>');
        MailBody.AppendLine(format(JCAEventParticipant.Result));
        MailBody.AppendLine('</p><img id="base64image" src="data:image/jpeg;base64,');
        MailBody.AppendLine(ResultImage);
        MailBody.AppendLine('"</img></div></div></html>');


        // MailBody.AppendLine('<html><head><style>');
        // MailBody.AppendLine('html{overflow-x: hidden;}');
        // MailBody.AppendLine('body{font-family: "Lato", sans-serif;margin: 0;background-color: white;}');
        // MailBody.AppendLine('.card{z-index: 1;position: relative;width: 300px;height:400px;margin: 0 auto;margin-top:100px;background-color: black;-webkit-box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);-moz-box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);-webkit-transition: all 0.7s ease-in-out;-moz-transition:    all 0.7s ease-in-out;-o-transition:      all 0.7s ease-in-out;-ms-transition:     all 0.7s ease-in-out;}');
        // MailBody.AppendLine('.banner{z-index: 2;position: relative;margin-top: -154px;width:100%;height:150px;');
        // MailBody.AppendLine('background-image: url("http://www.judoclubardooie.be/wp-content/uploads/2022/12/logo-JCA.png");');
        // MailBody.AppendLine('background-size: contain;background-repeat: no-repeat;border-bottom: solid 1px lightgrey;-webkit-transition: all 0.7s ease-in-out;-moz-transition:    all 0.7s ease-in-out;-o-transition:      all 0.7s ease-in-out;-ms-transition:     all 0.7s ease-in-out;}');
        // MailBody.AppendLine('.photo{z-index: 3;position: relative;border-radius: 50%;height: 150px;width: 150px;background-color: white;margin: 0 auto;');
        // //MailBody.AppendLine('background-image: url("https://filmshotfreezer.files.wordpress.com/2011/07/untitled-1.jpg");');
        // MailBody.AppendLine('background-image: url("data:image/jpeg;base64,');
        // MailBody.AppendLine(MemberPicture);
        // MailBody.AppendLine('");');
        // MailBody.AppendLine('background-size: cover;background-position: 50% 50%;top:75px;-webkit-box-shadow: inset 0px 0px 5px 1px rgba(0,0,0,0.3);-moz-box-shadow: inset 0px 0px 5px 1px rgba(0,0,0,0.3);box-shadow: inset 0px 0px 5px 1px rgba(0,0,0,0.3);-webkit-transition: top 0.7s ease-in-out, background 0.15s ease;-moz-transition:    top 0.7s ease-in-out, background 0.15s ease;-o-transition:      top 0.7s ease-in-out, background 0.15s ease;-ms-transition:     top 0.7s ease-in-out, background 0.15s ease;}');
        // MailBody.AppendLine('.card ul{list-style: none;text-align: center;padding-left: 0;margin-top:87px;margin-bottom:30px;font-size: 20px;-webkit-transition: all 0.7s ease-in-out;-moz-transition:    all 0.7s ease-in-out;-o-transition:      all 0.7s ease-in-out;-ms-transition:     all 0.7s ease-in-out;}');
        // MailBody.AppendLine('.card ul.active{opacity:0;visibility: hidden;}');
        // MailBody.AppendLine('.card i{font-size: 25px;display: inline-block;margin-top:10px;margin-left: 40px;margin-right: 150px;width: 300px;;text-align: left;color: #C7D0E1;}');
        // MailBody.AppendLine('</style></head');
        // MailBody.AppendLine('<body><div class="card"><div class="photo"></div><div class="banner"></div><ul><li><b>');
        // MailBody.AppendLine(JCAEventParticipant."Member Full Name");
        // MailBody.AppendLine('</b></li><li>');
        // MailBody.AppendLine(format(JCAEventParticipant.Result));
        // MailBody.AppendLine('</li></ul></div></body>');

    end;

    local procedure CollectEventAttachments(JCAEvent: record "JCA Event"; var JCAEventDocument: record "JCA Event Document")
    begin
        JCAEventDocument.Reset();
        JCAEventDocument.setrange("Event No.", JCAEvent."No.");
        JCAEventDocument.setrange("Add in Mails", true);
    end;
}
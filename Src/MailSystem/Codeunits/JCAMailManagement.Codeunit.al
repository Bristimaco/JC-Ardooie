codeunit 50104 "JCA Mail Management"
{
    procedure SendRegistrationConfirmationMail(JCAEventParticipant: record "JCA Event Participant"; JCAEvent: record "JCA Event"): Boolean
    begin
        exit(doSendRegistrationConfirmationMail(JCAEventParticipant."Member License ID", JCAEventParticipant."Weight Group Code", JCAEvent));
    end;

    procedure SendRegistrationConfirmationMail(JCAEventSupervisor: record "JCA Event Supervisor"; JCAEvent: record "JCA Event"): Boolean
    begin
        exit(doSendRegistrationConfirmationMail(JCAEventSupervisor."Member License ID", '', JCAEvent));
    end;

    procedure doSendRegistrationConfirmationMail(MemberLicenseID: code[50]; WeightGroupCode: code[20]; JCAEvent: record "JCA Event"): Boolean;
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

    procedure doSendUnRegistrationConfirmationMail(MemberLicenseID: code[50]; WeightGroupCode: Code[20]; JCAEvent: record "JCA Event"): Boolean
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

    procedure CheckForMailSystemTest(var SendToMail: text[100])
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

    procedure CollectCCMAilAddresses(JCAMember: Record "JCA Member"; var SendToCCList: list of [text[100]])
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

    local procedure CreateEventRegistrationConfirmationMailContent(LicenseID: code[50]; WeightGroupCode: code[20]; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder)
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

    local procedure CreateEventUnregistrationConfirmationMailContent(LicenseID: Code[50]; WeightGroupCode: Code[20]; JCAEvent: record "JCA Event"; var MailSubject: Text; var MailBody: TextBuilder)
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
}
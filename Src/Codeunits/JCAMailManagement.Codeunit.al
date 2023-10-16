codeunit 50104 "JCA Mail Management"
{
    procedure SendEventInvitationMail(MemberLicenseID: code[20]; JCAEvent: record "JCA Event"): Boolean
    var
        JCAMember: Record "JCA Member";
        JCAEventDocument: record "JCA Event Document";
        MailManagement: codeunit "Mail Management";
        EmailMessage: codeunit "Email Message";
        Email: codeunit Email;
        InStream: InStream;
        SendToMail: text[100];
        SendToCCList: list of [Text[100]];
        MailBody: TextBuilder;
        MailSubject: Text;
        AttachmentName: Text[250];
        CCEMail: text[100];
    begin
        JCAMember.Reset();
        JCAMember.get(MemberLicenseID);
        if JCAMember."E-Mail" = '' then
            exit(false);

        SendToMail := JCAMember."E-Mail";
        CheckForMailSystemTest(SendToMail);

        clear(MailManagement);
        if not MailManagement.CheckValidEmailAddress(SendToMail) then
            exit;

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
        exit(Email.Send(EmailMessage, enum::"Email Scenario"::Default));
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

    local procedure CollectEventAttachments(JCAEvent: record "JCA Event"; var JCAEventDocument: record "JCA Event Document")
    begin
        JCAEventDocument.Reset();
        JCAEventDocument.setrange("Event No.", JCAEvent."No.");
        JCAEventDocument.setrange("Add in Mails", true);
    end;
}
codeunit 50104 "JCA Mail Management"
{
    procedure SendEventInvitationMail(MemberLicenseID: code[20]; JCAEvent: record "JCA Event"): Boolean
    var
        JCAMember: Record "JCA Member";
        JCASetup: Record "JCA Setup";
        MailManagement: codeunit "Mail Management";
        EmailMessage: codeunit "Email Message";
        Email: codeunit Email;
        SendToMail: text[100];
    begin
        JCAMember.Reset();
        JCAMember.get(MemberLicenseID);
        if JCAMember."E-Mail" = '' then
            exit(false);

        JCASetup.Reset();
        JCASetup.get();
        if JCASetup."Send Test Mails" then begin
            JCASetup.TestField("Test E-Mail Address");
            SendToMail := JCASetup."Test E-Mail Address";
        end else
            SendToMail := JCAMember."E-Mail";

        clear(MailManagement);
        if not MailManagement.CheckValidEmailAddress(SendToMail) then
            exit;

        clear(EmailMessage);
        EmailMessage.Create(SendToMail, 'Invitation', 'Invitation for Event');
        clear(Email);
        exit(Email.Send(EmailMessage, enum::"Email Scenario"::Default));
    end;
}
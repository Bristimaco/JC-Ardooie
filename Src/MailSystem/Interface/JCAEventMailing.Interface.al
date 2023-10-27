interface JCAEventMailing
{
    procedure EditTemplate(JCAMailMessageTemplate: record "JCA Mail Message Template");
    procedure SendMail();
}
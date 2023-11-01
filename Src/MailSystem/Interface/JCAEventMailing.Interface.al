interface JCAEventMailing
{
    procedure EditTemplate(var JCAMailMessageTemplate: record "JCA Mail Message Template");
    procedure ReturnMailContent(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Text;
    procedure SendMail(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Boolean;
}
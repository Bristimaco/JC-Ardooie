codeunit 50112 "JCA Event Registration Mail" implements JCAEventMailing
{
    procedure EditTemplate(var JCAMailMessageTemplate: record "JCA Mail Message Template")
    begin

    end;

    procedure ReturnMailContent(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Text
    var
    begin
    end;

    procedure SendMail(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Boolean
    begin

    end;
}
codeunit 50111 "JCA Event Inv. Reminder Mail" implements JCAEventMailing
{
    procedure EditTemplate(var JCAMailMessageTemplate: record "JCA Mail Message Template")
    begin

    end;

    procedure ReturnMailContent(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Text
    var
    begin               
    end;
}
codeunit 50110 "JCA Event Invitation Mail" implements JCAEventMailing
{
    procedure EditTemplate(JCAMailMessageTemplate: record "JCA Mail Message Template")
    var
        JCAEventInvMailEditor: page "JCA Event Inv. Mail Editor";
    begin
        clear(JCAEventInvMailEditor);
        JCAEventInvMailEditor.SetTableView(JCAMailMessageTemplate);
        JCAEventInvMailEditor.run();
    end;

    procedure SendMail();
    begin

    end;
}
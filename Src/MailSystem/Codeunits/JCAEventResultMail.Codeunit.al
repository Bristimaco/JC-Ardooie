codeunit 50109 "JCA Event Result Mail" implements JCAEventMailing
{
    procedure EditTemplate(JCAMailMessageTemplate: record "JCA Mail Message Template")
    var
        JCAEventResultMailEditor: page "JCA Event Result Mail Editor";
    begin
        clear(JCAEventResultMailEditor);
        JCAEventResultMailEditor.SetTableView(JCAMailMessageTemplate);
        JCAEventResultMailEditor.run();
    end;

    procedure SendMail();
    begin

    end;
}
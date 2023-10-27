codeunit 50109 "JCA Event Result Mail" implements JCAEventMailing
{
    procedure EditTemplate(var JCAMailMessageTemplate: record "JCA Mail Message Template")
    var
        JCAEventResultMailEditor: page "JCA Event Result Mail Editor";
    begin        
        clear(JCAEventResultMailEditor);
        JCAEventResultMailEditor.SetTableView(JCAMailMessageTemplate);
        JCAEventResultMailEditor.run();
    end;

    procedure ReturnMailContent(var tempJCAMailMessageTemplate: record "JCA Mail Message Template" temporary): Text
    var
        JCAMember: record "JCA Member";
        JCASetup: Record "JCA Setup";
        JCAResultImage: record "JCA Result Image";
        JCAMailMessageTemplate: record "JCA Mail Message Template";
        MemberName: Text;
        MemberPicture: Text;
        ResultCardLogo: Text;
        ResultImage: Text;
        TemplateData: text;
        MailContent: Text;
    begin
        ResultCardLogo := '';
        JCASetup.Reset();
        JCASetup.get();
        ResultCardLogo := JCASetup.GetResultCardLogo();

        JCAMember.Reset();
        if JCAMember.get(tempJCAMailMessageTemplate."Member License ID") then begin
            MemberName := JCAMember."Full Name";
            MemberPicture := JCAMember.GetPicture();
        end;

        JCAResultImage.reset();
        if JCAResultImage.get(tempJCAMailMessageTemplate."Event Result") then
            ResultImage := JCAResultImage.GetImage();

        JCAMailMessageTemplate.Reset();
        JCAMailMessageTemplate.get(tempJCAMailMessageTemplate."Mail Message Type");
        JCAMailMessageTemplate.ReadTemplateData(TemplateData);
        MailContent := StrSubstNo(TemplateData, ResultCardLogo, MemberPicture, ResultImage, MemberName, UpperCase(format(tempJCAMailMessageTemplate."Event Result")));
        exit(MailContent);
    end;
}
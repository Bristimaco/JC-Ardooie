codeunit 50108 "JCA HTML Generator"
{
    procedure CreateHTMLHeader(var HTMLContent: TextBuilder; JCAHTMLGenCSSType: enum "JCA HTML Gen. CSS Type")
    begin
        HTMLContent.Clear();
        HTMLContent.AppendLine('<html>');
        HTMLContent.AppendLine('<header>');
        InjectCSS(HTMLContent, JCAHTMLGenCSSType);
        HTMLContent.AppendLine('</header>');
        HTMLContent.AppendLine('<body>');
    end;

    procedure InjectCSS(var HTMLContent: TextBuilder; JCAHTMLGenCSSType: enum "JCA HTML Gen. CSS Type")
    var
        JCAHTMLGenCSSTemplate: record "JCA HTML Gen. CSS Template";
        TemplateData: Text;
    begin
        JCAHTMLGenCSSTemplate.reset();
        JCAHTMLGenCSSTemplate.get(JCAHTMLGenCSSType);
        JCAHTMLGenCSSTemplate.ReadTemplateData(TemplateData);
        if TemplateData <> '' then begin
            HTMLContent.AppendLine('<style>');
            HTMLContent.AppendLine(TemplateData);
            HTMLContent.AppendLine('</style>');
        end;
    end;

    procedure CreateHTMLFooter(var HTMLContent: TextBuilder)
    begin
        HTMLContent.AppendLine('</body>');
        HTMLContent.AppendLine('</html>');
    end;

    procedure GetHTMLContent(HTMLContent: TextBuilder): text
    begin
        exit(HTMLContent.ToText());
    end;

    procedure CreateTable(var HTMLContent: TextBuilder; Class: Text)
    begin
        if Class = '' then
            HTMLContent.AppendLine('<table>')
        else
            HTMLContent.AppendLine('<table class="' + Class + '">');
    end;

    procedure CreateRow(var HTMLContent: TextBuilder; Class: Text)
    begin
        if Class = '' then
            HTMLContent.AppendLine('<tr>')
        else
            HTMLContent.AppendLine('<tr class="' + Class + '">');
    end;

    procedure CloseRow(var HTMLContent: TextBuilder)
    begin
        HTMLContent.AppendLine('</tr>');
    end;

    procedure CloseTable(var HTMLContent: TextBuilder)
    begin
        HTMLContent.AppendLine('</table>');
    end;

    procedure OpenTableDataField(var HTMLContent: TextBuilder; Class: Text)
    begin
        if Class = '' then
            HTMLContent.AppendLine('<td>')
        else
            HTMLContent.AppendLine('<td class="' + Class + '">');
    end;

    procedure CloseTableDataField(var HTMLContent: TextBuilder)
    begin
        HTMLContent.AppendLine('</td>');
    end;

    procedure CreateDataValue(var HTMLContent: TextBuilder; Value: Text; Class: Text)
    begin
        if Class = '' then
            HTMLContent.AppendLine('<div>')
        else
            HTMLContent.AppendLine('<div class="' + Class + '">');
        HTMLContent.AppendLine(value);
        HTMLContent.AppendLine('</div>');
    end;
}
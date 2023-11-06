codeunit 50120 "JCA Gen. HTML Event Results" implements "JCA HTML Generator"
{
    procedure GenerateHTML(RecordVariant: Variant): Text
    var
        JCAEvent: record "JCA Event";
        JCAHTMLGenerator: Codeunit "JCA HTML Generator";
        RecordRef: RecordRef;
        HTMLContent: TextBuilder;
    begin
        RecordRef.GetTable(RecordVariant);
        RecordRef.SetTable(JCAEvent);

        JCAHTMLGenerator.CreateHTMLHeader(HTMLContent, enum::"JCA HTML Gen. CSS Type"::"Event Result");
        JCAHTMLGenerator.CreateTable(HTMLContent, 'eventresultheader');
        JCAHTMLGenerator.CreateRow(HTMLContent, 'eventresult');
        JCAHTMLGenerator.CreateDataValue(HTMLContent, JCAEvent.Description, 'eventresulttitle');
        JCAHTMLGenerator.CloseRow(HTMLContent);
        JCAHTMLGenerator.CloseTable(HTMLContent);
        JCAHTMLGenerator.CreateHTMLFooter(HTMLContent);
        exit(JCAHTMLGenerator.GetHTMLContent(HTMLContent));
    end;
}
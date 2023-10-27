codeunit 50108 "JCA HTML Generator"
{
    procedure GenerateEventRsultHTML(JCAEvent: Record "JCA Event"): Text
    var
        HTMLContent: TextBuilder;
    begin
        CreateHTMLHeader(HTMLContent, enum::"JCA HTML Gen. CSS Type"::"Event Result");
        CreateTable(HTMLContent, 'eventresultheader');
        CreateRow(HTMLContent,'eventresult');
        CreateDataValue(HTMLContent,JCAEvent.Description,'eventresulttitle');        
        CloseRow(HTMLContent);
        CloseTable(HTMLContent);
        CreateHTMLFooter(HTMLContent);
        exit(GetHTMLContent(HTMLContent));
    end;

    procedure GenerateCalendarHTML(StartingDate: Date; EndingDate: date): Text
    var
        CalendarDayDate: Record Date;
        JCAEvent: record "JCA Event";
        JCATrainingSession: record "JCA Training Session";
        AdjustDate: record date;
        CurrentDate: Date;
        EventDescription: Text;
        LinesInDate: Integer;
        LinesToAdd: Integer;
        MinLinesInDate: Integer;
        Index: integer;
        HTMLContent: TextBuilder;
    begin
        MinLinesInDate := 10;
        CreateHTMLHeader(HTMLContent, enum::"JCA HTML Gen. CSS Type"::Calendar);

        CalendarDayDate.Reset();
        CalendarDayDate.setrange("Period Type", CalendarDayDate."Period Type"::Date);
        CalendarDayDate.setfilter("Period Start", '>=%1', StartingDate);
        CalendarDayDate.setfilter("Period End", '<=%1', EndingDate);

        CalendarDayDate.Findfirst();
        if CalendarDayDate."Period No." <> 1 then begin
            AdjustDate.reset();
            AdjustDate.setrange("Period Type", AdjustDate."Period Type"::Date);
            AdjustDate.setrange("Period No.", 1);
            AdjustDate.setfilter("Period Start", '<=%1', StartingDate);
            AdjustDate.findlast();
            CalendarDayDate.setfilter("Period Start", '>=%1', AdjustDate."Period Start");
        end;

        CalendarDayDate.findlast();
        if CalendarDayDate."Period No." <> 7 then begin
            AdjustDate.reset();
            AdjustDate.setrange("Period Type", AdjustDate."Period Type"::Date);
            AdjustDate.setrange("Period No.", 7);
            AdjustDate.setfilter("Period End", '>=%1', EndingDate);
            AdjustDate.findfirst();
            CalendarDayDate.setfilter("Period End", '<=%1', AdjustDate."Period End");
        end;

        if CalendarDayDate.findset() then begin
            CreateTable(HTMLContent, 'calendar');
            repeat
                CurrentDate := CalendarDayDate."Period Start";
                if Date2DWY(CurrentDate, 1) = 1 then
                    CreateRow(HTMLContent, 'calendarrow');

                OpenTableDataField(HTMLContent, 'calendardata');
                CreateDataValue(HTMLContent, format(CurrentDate), 'calendardate');
                CreateDataValue(HTMLContent, '&nbsp;', 'calendarvalue');
                LinesInDate := 2;

                if not ((CurrentDate < StartingDate) or (CurrentDate > EndingDate)) then begin
                    JCAEvent.Reset();
                    JCAEvent.setrange(Date, CurrentDate);
                    if JCAEvent.findset() then
                        repeat
                            EventDescription := JCAEvent.Description + JCAEvent.ReturnAgeGroupsText();
                            CreateDataValue(HTMLContent, EventDescription, 'calendarvalueevent');

                            LinesInDate += 1;
                        until JCAEvent.Next() = 0;

                    JCATrainingSession.Reset();
                    JCATrainingSession.setrange(Date, CurrentDate);
                    if JCATrainingSession.findset() then
                        repeat
                            JCATrainingSession.CalcFields("Training Group Description");
                            CreateDataValue(HTMLContent, JCATrainingSession."Training Group Description", 'calendarvaluetraining');
                            LinesInDate += 1;
                        until JCATrainingSession.Next() = 0;
                end;

                if LinesInDate < MinLinesInDate then begin
                    LinesToAdd := MinLinesInDate - LinesInDate;
                    for Index := 1 to LinesToAdd do
                        CreateDataValue(HTMLContent, '&nbsp;', 'calendarvalue');
                end;

                CloseTableDataField(HTMLContent);

                if Date2DWY(CurrentDate, 1) = 7 then
                    CloseRow(HTMLContent);
            until CalendarDayDate.Next() = 0;
            CloseTable(HTMLContent);
        end;
        CreateHTMLFooter(HTMLContent);
        exit(GetHTMLContent(HTMLContent));
    end;

    local procedure CreateHTMLHeader(var HTMLContent: TextBuilder; JCAHTMLGenCSSType: enum "JCA HTML Gen. CSS Type")
    begin
        HTMLContent.Clear();
        HTMLContent.AppendLine('<html>');
        HTMLContent.AppendLine('<header>');
        InjectCSS(HTMLContent, JCAHTMLGenCSSType);
        HTMLContent.AppendLine('</header>');
        HTMLContent.AppendLine('<body>');
    end;

    local procedure InjectCSS(var HTMLContent: TextBuilder; JCAHTMLGenCSSType: enum "JCA HTML Gen. CSS Type")
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

    local procedure CreateHTMLFooter(var HTMLContent: TextBuilder)
    begin
        HTMLContent.AppendLine('</body>');
        HTMLContent.AppendLine('</html>');
    end;

    local procedure GetHTMLContent(HTMLContent: TextBuilder): Text
    begin
        exit(HTMLContent.ToText());
    end;

    local procedure CreateTable(var HTMLContent: TextBuilder; Class: Text)
    begin
        if Class = '' then
            HTMLContent.AppendLine('<table>')
        else
            HTMLContent.AppendLine('<table class="' + Class + '">');
    end;

    local procedure CreateRow(var HTMLContent: TextBuilder; Class: Text)
    begin
        if Class = '' then
            HTMLContent.AppendLine('<tr>')
        else
            HTMLContent.AppendLine('<tr class="' + Class + '">');
    end;

    local procedure CloseRow(var HTMLContent: TextBuilder)
    begin
        HTMLContent.AppendLine('</tr>');
    end;

    local procedure CloseTable(var HTMLContent: TextBuilder)
    begin
        HTMLContent.AppendLine('</table>');
    end;

    local procedure OpenTableDataField(var HTMLContent: TextBuilder; Class: Text)
    begin
        if Class = '' then
            HTMLContent.AppendLine('<td>')
        else
            HTMLContent.AppendLine('<td class="' + Class + '">');
    end;

    local procedure CloseTableDataField(var HTMLContent: TextBuilder)
    begin
        HTMLContent.AppendLine('</td>');
    end;

    local procedure CreateDataValue(var HTMLContent: TextBuilder; Value: Text; Class: Text)
    begin
        if Class = '' then
            HTMLContent.AppendLine('<div>')
        else
            HTMLContent.AppendLine('<div class="' + Class + '">');
        HTMLContent.AppendLine(value);
        HTMLContent.AppendLine('</div>');
    end;
}
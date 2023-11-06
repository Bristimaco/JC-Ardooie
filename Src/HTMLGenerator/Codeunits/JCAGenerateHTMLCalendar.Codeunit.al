codeunit 50118 "JCA Generate HTML Calendar" implements "JCA HTML Generator"
{
    procedure GenerateHTML(RecordVariant: Variant): Text
    var
        FilterDate: Record Date;
        CalendarDayDate: Record Date;
        JCAEvent: record "JCA Event";
        JCATrainingSession: record "JCA Training Session";
        AdjustDate: record date;
        JCAHTMLGenerator: Codeunit "JCA HTML Generator";
        RecordRef: RecordRef;
        StartingDate: Date;
        EndingDate: date;
        CurrentDate: Date;
        EventDescription: Text;
        LinesInDate: Integer;
        LinesToAdd: Integer;
        MinLinesInDate: Integer;
        Index: integer;
        HTMLContent: TextBuilder;
    begin
        RecordRef.GetTable(RecordVariant);
        RecordRef.SetTable(FilterDate);

        FilterDate.FindFirst();
        StartingDate := FilterDate."Period Start";
        FilterDate.FindLast();
        EndingDate := FilterDate."Period start";

        MinLinesInDate := 10;
        JCAHTMLGenerator.CreateHTMLHeader(HTMLContent, enum::"JCA HTML Gen. CSS Type"::Calendar);

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
            JCAHTMLGenerator.CreateTable(HTMLContent, 'calendar');
            repeat
                CurrentDate := CalendarDayDate."Period Start";
                if Date2DWY(CurrentDate, 1) = 1 then
                    JCAHTMLGenerator.CreateRow(HTMLContent, 'calendarrow');

                JCAHTMLGenerator.OpenTableDataField(HTMLContent, 'calendardata');
                JCAHTMLGenerator.CreateDataValue(HTMLContent, format(CurrentDate), 'calendardate');
                JCAHTMLGenerator.CreateDataValue(HTMLContent, '&nbsp;', 'calendarvalue');
                LinesInDate := 2;

                if not ((CurrentDate < StartingDate) or (CurrentDate > EndingDate)) then begin
                    JCAEvent.Reset();
                    JCAEvent.setrange(Date, CurrentDate);
                    if JCAEvent.findset() then
                        repeat
                            EventDescription := JCAEvent.Description + JCAEvent.ReturnAgeGroupsText();
                            JCAHTMLGenerator.CreateDataValue(HTMLContent, EventDescription, 'calendarvalueevent');

                            LinesInDate += 1;
                        until JCAEvent.Next() = 0;

                    JCATrainingSession.Reset();
                    JCATrainingSession.setrange(Date, CurrentDate);
                    if JCATrainingSession.findset() then
                        repeat
                            JCATrainingSession.CalcFields("Training Group Description");
                            JCAHTMLGenerator.CreateDataValue(HTMLContent, JCATrainingSession."Training Group Description", 'calendarvaluetraining');
                            LinesInDate += 1;
                        until JCATrainingSession.Next() = 0;
                end;

                if LinesInDate < MinLinesInDate then begin
                    LinesToAdd := MinLinesInDate - LinesInDate;
                    for Index := 1 to LinesToAdd do
                        JCAHTMLGenerator.CreateDataValue(HTMLContent, '&nbsp;', 'calendarvalue');
                end;

                JCAHTMLGenerator.CloseTableDataField(HTMLContent);

                if Date2DWY(CurrentDate, 1) = 7 then
                    JCAHTMLGenerator.CloseRow(HTMLContent);
            until CalendarDayDate.Next() = 0;
            JCAHTMLGenerator.CloseTable(HTMLContent);
        end;
        JCAHTMLGenerator.CreateHTMLFooter(HTMLContent);
        exit(JCAHTMLGenerator.GetHTMLContent(HTMLContent));
    end;

}
enum 50108 "JCA Mail Message Type" implements "JCA Event Mailing"
{
    value(0; Invitation)
    {
        Caption = 'Invitation';
        Implementation = "JCA Event Mailing" = "JCA Event Invitation Mail";
    }
    value(1; "Invitation Reminder")
    {
        Caption = 'Invitation Reminder';
        Implementation = "JCA Event Mailing" = "JCA Event Inv. Reminder Mail";
    }
    value(2; "Event Registration")
    {
        Caption = 'Event Registration';
        Implementation = "JCA Event Mailing" = "JCA Event Registration Mail";
    }
    value(3; "Event Unregistation")
    {
        Caption = 'Event Unregistration';
        Implementation = "JCA Event Mailing" = "JCA Event Unregistration Mail";
    }
    value(4; "Event Result")
    {
        Caption = 'Event Result';
        Implementation = "JCA Event Mailing" = "JCA Event Result Mail";
    }
    value(5; "Grouped Event Result")
    {
        Caption = 'Grouped Event Result';
        Implementation = "JCA Event Mailing" = "JCA Grouped Event Result Mail";
    }
}
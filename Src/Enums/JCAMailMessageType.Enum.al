enum 50108 "JCA Mail Message Type" implements JCAEventMailing
{
    value(0; Invitation)
    {
        Caption = 'Invitation';
        Implementation = JCAEventMailing = "JCA Event Invitation Mail";
    }
    value(1; "Invitation Reminder")
    {
        Caption = 'Invitation Reminder';
        Implementation = JCAEventMailing = "JCA Event Inv. Reminder Mail";
    }
    value(2; "Event Registration")
    {
        Caption = 'Event Registration';
        Implementation = JCAEventMailing = "JCA Event Registration Mail";
    }
    value(3; "Event Unregistation")
    {
        Caption = 'Event Unregistration';
        Implementation = JCAEventMailing = "JCA Event Unregistration Mail";
    }
    value(4; "Event Result")
    {
        Caption = 'Event Result';
        Implementation = JCAEventMailing = "JCA Event Result Mail";
    }
}
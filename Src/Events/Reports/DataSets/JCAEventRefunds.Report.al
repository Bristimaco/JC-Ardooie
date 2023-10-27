report 50101 "JCA Event Refunds"
{
    Caption = 'Event Refunds';
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src/Reports/RDLC/JCAEventRefunds.rdl';
    UsageCategory = None;

    dataset
    {

        dataitem("JCA Event Participant"; "JCA Event Participant")
        {
            RequestFilterFields = "Member License ID";
            DataItemTableView = where("No-Show" = const(true), "Refund Payed" = const(false));

            column(Member_License_ID; "Member License ID")
            { }
            column(Member_Full_Name; "Member Full Name")
            { }

            dataitem("JCA Event"; "JCA Event")
            {
                RequestFilterFields = Date;
                DataItemLink = "No." = field("Event No.");
                DataItemTableView = where("Fee Payment" = const("Payed by Club"));

                column(No_; "No.")
                { }
                column(Description; Description)
                { }
                column(Date; Date)
                { }
                column(Registration_Fee; "Registration Fee")
                { }
            }
        }
    }
}
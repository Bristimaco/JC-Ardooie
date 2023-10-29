report 50100 "JCA Event Report"
{
    Caption = 'Event Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Src/Events/Reports/RDLC/JCAEventReport.rdl';
    UsageCategory = None;

    dataset
    {
        dataitem("JCA Event"; "JCA Event")
        {
            RequestFilterFields = "No.", Date;

            column(No_; "No.")
            { }
            column(Description; Description)
            { }
            column(Type; Type)
            { }
            column(Country_Code; "Country Code")
            { }
            column(Date; Date)
            { }

            dataitem("JCA Event Supervisor"; "JCA Event Supervisor")
            {
                DataItemLink = "Event No." = field("No.");
                DataItemTableView = sorting("Event No.", "Member License ID");

                column(Supervisor_License_ID; "Member License ID")
                { }
                column(Supervisor_Full_Name; "Member Full Name")
                { }
            }

            dataitem("JCA Event Age Group"; "JCA Event Age Group")
            {
                DataItemLink = "Event No." = field("No."), "Country Code" = field("Country Code");
                DataItemTableView = sorting("Event No.", "Country Code", Gender, "Age Group Code");

                column(Gender; Gender)
                { }
                column(Age_Group_Description; "Age Group Description")
                { }
                column(Weigh_In_Start_Time; "Weigh-In Start Time")
                { }

                dataitem("JCA Event Participant"; "JCA Event Participant")
                {
                    DataItemLink = "Event No." = Field("Event No."), Gender = field(Gender), "Age Group Code" = field("Age Group Code");
                    DataItemTableView = sorting("Event No.", "Member License ID");

                    column(Member_License_ID; "Member License ID")
                    { }
                    column(Member_Full_Name; "Member Full Name")
                    { }
                    column(Result; Result)
                    { }
                    column(Supervisor_Comment; "Supervisor Comment")
                    { }
                    column(No_Show; "No-Show")
                    { }
                }
            }
        }
    }

    var
        ReportTitleLbl: label 'Event Report';
}
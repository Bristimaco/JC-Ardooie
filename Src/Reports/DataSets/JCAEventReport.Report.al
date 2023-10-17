report 50100 "JCA Event Report"
{
    Caption = 'Event Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Src/Reports/RDLC/JCAEventReport.rdl';
    UsageCategory = None;

    dataset
    {
        dataitem("JCA Event"; "JCA Event")
        {
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

                column(Supervisor_License_ID; "Member License ID")
                { }
                column(Supervisor_Full_Name; "Member Full Name")
                { }
            }

            dataitem("JCA Event Age Group"; "JCA Event Age Group")
            {
                DataItemLink = "Event No." = field("No."), "Country Code" = field("Country Code");

                column(Gender; Gender)
                { }
                column(Age_Group_Description; "Age Group Description")
                { }
                column(Weigh_In_Start_Time; "Weigh-In Start Time")
                { }

                dataitem("JCA Event Participant"; "JCA Event Participant")
                {
                    DataItemLink = "Event No." = Field("Event No."), Gender = field(Gender), "Age Group Code" = field("Age Group Code");

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
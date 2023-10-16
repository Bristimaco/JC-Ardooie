page 50129 "JCA Training Attendance"
{
    Caption = 'Training Attendance';
    SourceTable = "JCA Tr. Session Participant";
    PageType = List;
    UsageCategory = None;
    SourceTableView = where(Participation = const(true));
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            field(AttendeeLicenseID; AttendeeLicenseID)
            {
                Caption = 'License ID';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;

                trigger OnValidate()
                begin
                    Rec.ProcessTrainingAttendeeScan(AttendeeLicenseID);
                    AttendeeLicenseID := '';
                    CurrPage.update();
                end;
            }
            repeater(Attendees)
            {
                field("Member License ID"; Rec."Member License ID")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Member Full Name"; Rec."Member Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Club Name"; Rec."Club Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Belt; Rec.Belt)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }

    var
        AttendeeLicenseID: code[20];
}
page 50122 "JCA Member Contacts"
{
    Caption = 'Member Contacts';
    UsageCategory = None;
    PageType = ListPart;
    SourceTable = "JCA Member Contact";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Contacts)
            {
                field("Contact ID"; Rec."Contact No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Contact Full Name"; Rec."Contact Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Contact E-Mail"; Rec."Contact E-Mail")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Contact Phone No."; Rec."Contact Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
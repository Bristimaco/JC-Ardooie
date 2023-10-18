page 50100 "JCA Setup"
{
    Caption = 'Setup';
    ApplicationArea = all;
    UsageCategory = Administration;
    SourceTable = "JCA Setup";
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(NoSeries)
            {
                Caption = 'Number Series';

                field("Training Session Nos."; Rec."Training Session Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Event Nos."; Rec."Event Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Contact Nos."; Rec."Contact Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }

            group(Invoicing)
            {
                Caption = 'Invoicing';

                field("Training G/L Account No."; Rec."Training G/L Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Training G/L Acc. Description"; Rec."Training G/L Acc. Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Participant Unit Price"; Rec."Participant Unit Price")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Trainer Unit Price"; Rec."Trainer Unit Price")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }

            group(MailSystem)
            {
                Caption = 'Mail System';

                field("Send Test Mails"; Rec."Send Test Mails")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Test E-Mail Address"; Rec."Test E-Mail Address")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty() then begin
            Rec.Init();
            Rec.insert();
        end;
    end;
}
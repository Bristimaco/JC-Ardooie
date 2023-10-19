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

    actions
    {
        area(Processing)
        {
            action(Countries)
            {
                Caption = 'Countries';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "Countries/Regions";
                Image = CountryRegion;
            }
            action(Memberships)
            {
                Caption = 'Memberships';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Memberships";
                Image = Price;
            }
            action(Clubs)
            {
                Caption = 'Clubs';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Clubs";
                Image = ItemGroup;
            }
            action(TrainingGroups)
            {
                Caption = 'Training Groups';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Training Groups";
                Image = VoucherGroup;
            }
            action(AgeGroups)
            {
                Caption = 'Age Groups';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Age Groups";
                Image = Aging;
            }
            action(WeightGroups)
            {
                Caption = 'Weight Groups';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Weight Groups";
                Image = ItemGroup;
            }
            action(ActionLogs)
            {
                Caption = 'Logs';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Action Logs";
                Image = Log;
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
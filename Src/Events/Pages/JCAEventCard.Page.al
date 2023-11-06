page 50117 "JCA Event Card"
{
    Caption = 'Event Card';
    SourceTable = "JCA Event";
    PageType = Card;
    UsageCategory = None;
    DataCaptionExpression = format(Rec.Type) + ' - ' + rec.Description;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                group(EventAddress)
                {
                    Caption = 'Address';

                    field(Address; Rec.Address)
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Country Code"; Rec."Country Code")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }

                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Registration Deadline"; Rec."Registration Deadline")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Send Result Mails"; Rec."Send Result Mails")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }
                field("Send Invitation Reminders"; Rec."Send Invitation Reminders")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', locked = true;
                }

                group(Financials)
                {
                    Caption = 'Financials';

                    field("Fee Payment"; Rec."Fee Payment")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Fee Payed To"; Rec."Fee Payed To No.")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Fee Payed To Name"; Rec."Fee Payed To Name")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Registration Fee"; Rec."Registration Fee")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }

                group(Progress)
                {
                    Caption = 'Progress';

                    field("Potential Participants"; Rec."Potential Participants")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', locked = true;
                    }
                    field("Invited Participants"; Rec."Invited Participants")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', locked = true;
                    }
                    field("Registered Participants"; Rec."Registered Participants")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', locked = true;
                    }
                }
            }

            group(EventSpecifics)
            {
                Caption = 'Specifics';

                part(AgeGroups; "JCA Event Age Groups")
                {
                    Caption = 'Event Age Groups';
                    SubPageLink = "Event No." = field("No."), "Country Code" = field("Country Code");
                    ApplicationArea = all;
                    UpdatePropagation = Both;
                }

                part(EventDocuments; "JCA Event Documents")
                {
                    Caption = 'Documents';
                    ApplicationArea = all;
                    SubPageLink = "Event No." = field("No.");
                }
            }

            part(EventSupervisors; "JCA Event Supervisors")
            {
                Caption = 'Event Supervisors';
                SubPageLink = "Event No." = field("No.");
                ApplicationArea = all;
                UpdatePropagation = Both;
            }

            part(Participants; "JCA Event Participants")
            {
                Caption = 'Event Participants';
                SubPageLink = "Event No." = field("No.");
                ApplicationArea = all;
                UpdatePropagation = Both;
            }
        }

        area(FactBoxes)
        {
            part(EventFolderPDF; "JCA PDF Viewer Part")
            {
                Caption = 'PDF Viewer';
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(FetchPatricipants)
            {
                Caption = 'Fetch Participants';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = GetEntries;

                trigger OnAction()
                begin
                    Rec.FetchParticipants();
                    CurrPage.Update();
                end;
            }
            action(SendInvitations)
            {
                Caption = 'Send Invitations';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = SendMail;

                trigger OnAction()
                begin
                    Rec.SendInvitations();
                    CurrPage.Update();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        JCAEventDocument: record "JCA Event Document";        
    begin
        JCAEventDocument.Reset();
        JCAEventDocument.setrange("Event No.", Rec."No.");
        JCAEventDocument.setrange(folder, true);
        if JCAEventDocument.FindFirst() then 
            CurrPage.EventFolderPDF.Page.LoadPdfFromBase64(JCAEventDocument.GetDataAsBase64());
    end;
}
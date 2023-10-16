page 50102 "JCA Member Card"
{
    Caption = 'Member Card';
    UsageCategory = None;
    SourceTable = "JCA Member";
    PageType = Card;
    DelayedInsert = true;
    DataCaptionExpression = Rec."License ID" + ' - ' + rec."Full Name";

    layout
    {
        area(Content)
        {
            group(PersonalInformation)
            {
                Caption = 'Personal Information';

                field("License ID"; Rec."License ID")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }

                group(ContactInformation)
                {
                    Caption = 'Contact Information';

                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Send Result Mails"; Rec."Send Result Mails")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }
            }

            group(Characteristics)
            {
                Caption = 'Characteristics';

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Belt; Rec.Belt)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;

                    trigger OnValidate()
                    begin
                        if Rec.Belt <> Rec.Belt::Black then
                            Rec.Dan := 0;
                        CalculateDanFieldVisibility();
                    end;
                }
                field(Dan; Rec.Dan)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    Editable = DanFieldVisible;
                }
            }

            part(AgeGroups; "JCA Member Age Groups")
            {
                Caption = 'Age Groups';
                ApplicationArea = all;
                SubPageLink = "Member License ID" = field("License ID");
            }

            group(Membership)
            {
                Caption = 'Membership';

                field("Member Since"; Rec."Member Since")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Member Until"; Rec."Member Until")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Active Member"; Rec."Active Member")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Member Type"; Rec."Member Type")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }

            part(TrainingGroups; "JCA Member Training Groups")
            {
                Caption = 'Training Groups';
                ApplicationArea = all;
                SubPageLink = "Member License ID" = field("License ID");
                UpdatePropagation = Both;
            }
            part(Contacts; "JCA Member Contacts")
            {
                Caption = 'Contacts';
                ApplicationArea = all;
                SubPageLink = "Member License ID" = field("License ID");
                UpdatePropagation = Both;
            }
        }

        area(FactBoxes)
        {
            part(MemberInformation; "JCA Member Factbox")
            {
                Caption = 'Member Information';
                ApplicationArea = all;
                SubPageLink = "License ID" = field("License ID");
                UpdatePropagation = both;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Date Filter", '=%1&<%2', 0D, Today());
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CalculateDanFieldVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateDanFieldVisibility();
    end;

    local procedure CalculateDanFieldVisibility()
    begin
        DanFieldVisible := Rec.Belt = Rec.Belt::Black;
    end;

    var
        DanFieldVisible: Boolean;
}
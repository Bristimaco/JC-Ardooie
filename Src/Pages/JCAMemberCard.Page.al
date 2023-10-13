page 50102 "JCA Member Card"
{
    Caption = 'Member Card';
    UsageCategory = None;
    SourceTable = "JCA Member";
    PageType = Card;
    DelayedInsert = true;

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
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Date Filter", '=%1&<%2', 0D, Today());
    end;
}
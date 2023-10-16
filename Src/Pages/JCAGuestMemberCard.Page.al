page 50133 "JCA Guest Member Card"
{
    Caption = 'Guest Member Card';
    SourceTable = "JCA Guest Member";
    PageType = Card;

    layout
    {
        area(Content)
        {
            group(General)
            {
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
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }

                group(Communication)
                {
                    Caption = 'Communication';

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
                field(Active; Rec.Active)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }

            group(Characteristics)
            {
                Caption = 'Characteristics';

                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Belt; Rec.Belt)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Dan; Rec.Dan)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                group(Club)
                {
                    Caption = 'Club';

                    field("Club No."; Rec."Club No.")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Club Name"; Rec."Club Name")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }
            }

            part(TrainingGroups; "JCA Guest Member Tr. Groups")
            {
                Caption = 'Training Groups';
                ApplicationArea = all;
                SubPageLink = "Guest Member License ID" = field("License ID");
                UpdatePropagation = Both;
            }
        }
    }
}
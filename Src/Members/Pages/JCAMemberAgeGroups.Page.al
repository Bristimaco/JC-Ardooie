page 50114 "JCA Member Age Groups"
{
    Caption = 'Member Age Groups';
    Editable = false;
    PageType = ListPart;
    SourceTable = "JCA Member Age Group";

    layout
    {
        area(Content)
        {
            repeater(MemberAgeGroups)
            {
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group Code"; Rec."Age Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group Description"; Rec."Age Group Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
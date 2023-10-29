page 50147 "JCA Injury Card"
{
    Caption = 'Injury Card';
    SourceTable = "JCA Injury";
    PageType = Card;
    InsertAllowed = false;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(general)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Short Description"; Rec."Short Description")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }

                group(Member)
                {
                    Caption = 'Member';

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
                }

                group(Relation)
                {
                    Caption = 'Relation';

                    field("Related To"; Rec."Related To")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Related To No."; Rec."Related To No.")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Related To Description"; Rec."Related To Description")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }

                group(Dates)
                {
                    Caption = 'Dates';

                    field(Date; Rec.Date)
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Expected End Date"; Rec."Expected End Date")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }

                group(Insurance)
                {
                    Caption = 'Insurance';

                    field("Insurance Status"; Rec."Insurance Status")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }
            }

            group(InjuryDescription)
            {
                Caption = 'Injury Description';

                usercontrol(InjuryDescriptionText; TinyMCEEditor)
                {
                    ApplicationArea = all;

                    trigger ControlAddInReady(IsReady: Boolean)
                    begin
                        rec.ReadInjuryDescription(InjuryDescription);
                        CurrPage.InjuryDescriptionText.InitContent(true, true);
                    end;

                    trigger DocumentReady(IsReady: Boolean)
                    begin
                        CurrPage.InjuryDescriptionText.SetContent(InjuryDescription);
                    end;

                    trigger ContentHasSaved()
                    begin
                        CurrPage.InjuryDescriptionText.GetContent();
                    end;

                    trigger ContentText(Contents: Text; IsText: Boolean)
                    begin
                        rec.WriteInjuryDescription(contents);
                    end;
                }
            }
        }
    }

    var
        InjuryDescription: Text;
}
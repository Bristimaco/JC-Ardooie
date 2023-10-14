page 50115 "JCA Event Cues"
{
    Caption = 'Events';
    SourceTable = "JCA Cue";
    RefreshOnActivate = true;
    PageType = CardPart;

    layout
    {
        area(Content)
        {
            group(Tournaments)
            {
                Caption = 'Tournaments';

                cuegroup(TournamentsCuegroup)
                {
                    ShowCaption = false;

                    field("New Tournaments"; Rec."New Tournaments")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Tournaments (Inv. Sent)"; Rec."Tournaments (Inv. Sent)")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Tournaments (Reg)"; Rec."Tournaments (Reg)")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Tournaments (RegClosed)"; Rec."Tournaments (RegClosed)")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Tournaments (RegProc)"; Rec."Tournaments (RegProc)")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                    field("Tournaments (Archived)"; Rec."Tournaments (Archived)")
                    {
                        ApplicationArea = all;
                        ToolTip = ' ', Locked = true;
                    }
                }

                group(Stages)
                {
                    Caption = 'Stages';

                    cuegroup(StagesCuegroup)
                    {
                        ShowCaption = false;

                        field("New Stages"; Rec."New Stages")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Stages (Inv. Sent)"; Rec."Stages (Inv. Sent)")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Stages (Reg))"; Rec."Stages (Reg))")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Stages (RegClosed))"; Rec."Stages (RegClosed))")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Stages (RegProc))"; Rec."Stages (RegProc))")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Stages (Archived))"; Rec."Stages (Archived))")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                    }
                }

                group(Chiai)
                {
                    Caption = 'Chiai';

                    cuegroup(ChiaiCueGroup)
                    {
                        ShowCaption = false;

                        field("New Chiai"; Rec."New Chiai")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Chiai (Inv. Sent)"; Rec."Chiai (Inv. Sent)")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Chiai (Reg)"; Rec."Chiai (Reg)")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Chiai (RegClosed)"; Rec."Chiai (RegClosed)")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Chiai (RecProc)"; Rec."Chiai (RecProc)")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                        field("Chiai (Archived)"; Rec."Chiai (Archived)")
                        {
                            ApplicationArea = all;
                            ToolTip = ' ', Locked = true;
                        }
                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty() then begin
            Rec.init();
            Rec.insert();
        end;
    end;
}
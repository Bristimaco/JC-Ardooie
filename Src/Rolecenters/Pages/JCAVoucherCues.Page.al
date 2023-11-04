page 50152 "JCA Voucher Cues"
{
    Caption = 'Vouchers';
    SourceTable = "JCA Cue";
    PageType = CardPart;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(Vouchers)
            {
                Caption = 'Vouchers';

                field("Unused Vouchers"; Rec."Unused Vouchers")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Used Vouchers"; Rec."Used Vouchers")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }        
        }
    }
}
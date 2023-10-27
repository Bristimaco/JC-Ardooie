page 50139 "JCA Vouchers"
{
    Caption = 'Vouchers';
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "JCA Voucher";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Vouchers)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Issued To License ID"; Rec."Issued To License ID")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Issued To Name"; Rec."Issued To Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Valid Until"; Rec."Valid Until")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Used; Rec.Used)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Used On"; Rec."Used On")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
page 50138 "JCA Voucher Types"
{
    Caption = 'Voucher Types';
    SourceTable = "JCA Voucher Type";
    DelayedInsert = true;
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(VoucherTypes)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field(value; Rec.value)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Validation Period"; Rec."Validation Period")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Voucher Nos."; Rec."Voucher Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
    }
}
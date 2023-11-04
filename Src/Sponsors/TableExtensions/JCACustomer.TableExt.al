tableextension 50102 "JCA Customer" extends Customer
{
    fields
    {
        field(50100; "JCA Sponsor"; Boolean)
        {
            Caption = 'Sponsor';
            DataClassification = SystemMetadata;
        }
        field(50101; "JCA Sponsor Formula"; Code[20])
        {
            Caption = 'Sponsor Formula';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Sponsor Formula".Code;

            trigger OnValidate()
            begin
                CalcFields("JCA Sponsor Form. Descr.");
            end;
        }
        field(50102; "JCA Sponsor Form. Descr."; text[100])
        {
            Caption = 'Sponsor Formula Descriptoon';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Sponsor Formula".Description where(Code = field("JCA Sponsor Formula")));
            Editable = false;
        }
    }

    procedure IssueVoucher(VoucherType: Code[20])
    var
        JCAVoucherManagement: codeunit "JCA Voucher Management";
    begin
        clear(JCAVoucherManagement);
        JCAVoucherManagement.IssueVoucherToSponsor(Rec, VoucherType);
    end;
}
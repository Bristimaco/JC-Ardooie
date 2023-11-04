codeunit 50115 "JCA Voucher Management"
{
    procedure IssueVoucherToMember(JCAMember: record "JCA Member"; VoucherType: Code[20])
    var
        JCAVoucherType: Record "JCA Voucher Type";
        JCAVoucher: Record "JCA Voucher";
    begin
        JCAVoucherType.Reset();
        JCAVoucherType.get(VoucherType);
        JCAVoucherType.testfield("Voucher Nos.");

        JCAVoucher.Reset();
        JCAVoucher.init();
        JCAVoucher.validate(type, JCAVoucherType.Code);
        JCAVoucher.insert(true);
        JCAVoucher.Validate("Issued To No.", JCAMember."License ID");
        JCAVoucher.validate("Valid Until", CalcDate(JCAVoucherType."Validation Period", JCAVoucher."Issued On"));
        JCAVoucher.modify(true);
    end;

    procedure IssueVoucherToSponsor(Customer: record Customer; VoucherType: Code[20])
    var
        JCAVoucherType: Record "JCA Voucher Type";
        JCAVoucher: Record "JCA Voucher";
    begin
        JCAVoucherType.Reset();
        JCAVoucherType.get(VoucherType);
        JCAVoucherType.testfield("Voucher Nos.");

        JCAVoucher.Reset();
        JCAVoucher.init();
        JCAVoucher.validate(type, JCAVoucherType.Code);
        JCAVoucher.insert(true);
        JCAVoucher.Validate("Issued To No.", Customer."No.");
        JCAVoucher.validate("Valid Until", CalcDate(JCAVoucherType."Validation Period", JCAVoucher."Issued On"));
        JCAVoucher.modify(true);
    end;
}
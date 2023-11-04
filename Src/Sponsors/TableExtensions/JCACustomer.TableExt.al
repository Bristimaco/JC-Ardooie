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
        field(50104; "JCA Active Sponsorship"; Code[20])
        {
            Caption = 'Active Sponsorship';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Sponsorship Period"."Sponsorship Code" where("Sponsor No." = field("No."), "Sponsorship Payed" = const(true), "Sponsorship Starting Date" = field("JCA SpSh. Start Date Filter"), "Sponsorship Ending Date" = field("JCA SpSh. End Date Filter")));
        }
        field(50105; "JCA SpSh. Start Date Filter"; Date)
        {
            Caption = 'Sponsorship Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(50106; "JCA SpSh. End Date Filter"; Date)
        {
            Caption = 'Sponsorship End Date Filter';
            FieldClass = FlowFilter;
        }
        field(50107; "JCA Req. Sponsorship Code"; Code[20])
        {
            Caption = 'Requested Sponsorship Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Membership".Code;
        }
        field(50108; "JCA Open SpShip Payment Req."; Boolean)
        {
            Caption = 'Open Sponsorship Payment Requests';
            FieldClass = FlowField;
            CalcFormula = exist("JCA Sponsorship Period" where("Sponsorship Payed" = const(false), "Sponsor No." = field("No.")));
            Editable = false;
        }
        field(50109; "Unused Vouchers"; Integer)
        {
            Caption = 'Unused Vouchers';
            FieldClass = FlowField;
            CalcFormula = count("JCA Voucher" where("Issued To Type" = const(sponsor), "Issued To No." = field("No."), Used = const(false)));
            Editable = false;
        }
        field(50110; "Used Vouchers"; Integer)
        {
            Caption = 'Used Vouchers';
            FieldClass = FlowField;
            CalcFormula = count("JCA Voucher" where("Issued To Type" = const(sponsor), "Issued To No." = field("No."), Used = const(true)));
            Editable = false;
        }
    }

    procedure CreateSponsorshipRenewal()
    var
        JCASponsorManagement: codeunit "JCA Sponsor Management";
    begin
        Clear(JCASponsorManagement);
        JCASponsorManagement.CreateSponsorshipRenewal(Rec);
    end;

    procedure IssueVoucher(VoucherType: Code[20])
    var
        JCAVoucherManagement: codeunit "JCA Voucher Management";
    begin
        clear(JCAVoucherManagement);
        JCAVoucherManagement.IssueVoucherToSponsor(Rec, VoucherType);
    end;
}
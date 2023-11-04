table 50101 "JCA Member"
{
    Caption = 'Member';
    LookupPageId = "JCA Members";
    DrillDownPageId = "JCA Members";

    fields
    {
        field(1; "License ID"; Code[50])
        {
            Caption = 'License ID';
            DataClassification = SystemMetadata;
        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                ManageFullName();
            end;
        }
        field(3; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                ManageFullName();
            end;
        }
        field(4; "Full Name"; Text[150])
        {
            Caption = 'Full Name';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                UpdateAgeGroups(today(), true, tempgJCAMemberAgeGroup);
            end;
        }
        field(6; "Member Since"; Date)
        {
            Caption = 'Member Since';
            FieldClass = FlowField;
            CalcFormula = min("JCA Membership Period"."Membership starting Date" where("Member License ID" = field("License ID"), "Membership Payed" = const(true)));
            Editable = false;
        }
        field(7; "Member Until"; Date)
        {
            Caption = 'Member Until';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Membership Period"."Membership Ending Date" where("Member License ID" = field("License ID"), "Membership Payed" = const(true), "Membership Starting Date" = field("Membersh. Start Date Filter"), "Membership Ending Date" = field("Membersh. End Date Filter")));
            Editable = false;
        }
        field(9; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(10; Gender; enum "JCA Gender")
        {
            Caption = 'Gender';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                UpdateAgeGroups(Today(), true, tempgJCAMemberAgeGroup);
            end;
        }
        field(11; Age; Integer)
        {
            Caption = 'Age';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(14; "Member Type"; Enum "JCA Member Type")
        {
            Caption = 'Member Type';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                UpdateAgeGroups(Today(), true, tempgJCAMemberAgeGroup);
            end;
        }
        field(15; "E-Mail"; text[100])
        {
            Caption = 'E-Mail';
            DataClassification = SystemMetadata;
        }
        field(16; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = SystemMetadata;
        }
        field(17; Belt; enum "JCA Belt")
        {
            caption = 'Belt';
            DataClassification = SystemMetadata;
        }
        field(18; Dan; Integer)
        {
            Caption = 'Dan';
            DataClassification = SystemMetadata;
        }
        field(19; Picture; MediaSet)
        {
            Caption = 'Picture';
            DataClassification = SystemMetadata;
        }
        field(20; "Send Result Mails"; Boolean)
        {
            Caption = 'Send Result Mails';
            DataClassification = SystemMetadata;
        }
        field(21; "Gold Medals"; Integer)
        {
            Caption = 'Gold Medals';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event Participant" where("Member License ID" = field("License ID"), Result = const(Gold)));
            Editable = false;
        }
        field(22; "Silver Medals"; Integer)
        {
            Caption = 'Silver Medals';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event Participant" where("Member License ID" = field("License ID"), Result = const(Silver)));
            Editable = false;
        }
        field(23; "Bronze Medals"; Integer)
        {
            Caption = 'Bronze Medals';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event Participant" where("Member License ID" = field("License ID"), Result = const(Bronze)));
            Editable = false;
        }
        field(24; "Active Membership"; Code[20])
        {
            Caption = 'Active Membership';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Membership Period"."Membership Code" where("Member License ID" = field("License ID"), "Membership Payed" = const(true), "Membership Starting Date" = field("Membersh. Start Date Filter"), "Membership Ending Date" = field("Membersh. End Date Filter")));
        }
        field(25; "Membersh. Start Date Filter"; Date)
        {
            Caption = 'Membership Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(26; "Membersh. End Date Filter"; Date)
        {
            Caption = 'Membership End Date Filter';
            FieldClass = FlowFilter;
        }
        field(27; "Requested Membership Code"; Code[20])
        {
            Caption = 'Requested Membership Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Membership".Code;
        }
        field(28; "Open Membership Payment Req."; Boolean)
        {
            Caption = 'Open Membership Payment Requests';
            FieldClass = FlowField;
            CalcFormula = exist("JCA Membership Period" where("Membership Payed" = const(false), "Member License ID" = field("License ID")));
            Editable = false;
        }
        field(29; "Unused Vouchers"; Integer)
        {
            Caption = 'Unused Vouchers';
            FieldClass = FlowField;
            CalcFormula = count("JCA Voucher" where("Issued To No." = field("License ID"), Used = const(false)));
            Editable = false;
        }
        field(30; "Used Vouchers"; Integer)
        {
            Caption = 'Used Vouchers';
            FieldClass = FlowField;
            CalcFormula = count("JCA Voucher" where("Issued To No." = field("License ID"), Used = const(true)));
            Editable = false;
        }
        field(31; "Current Injuries"; Integer)
        {
            Caption = 'Current Injuries';
            FieldClass = FlowField;
            CalcFormula = count("JCA Injury" where(Status = const(Open), "Member License ID" = field("License ID")));
            Editable = false;
        }
        field(32; "Past Injuries"; Integer)
        {
            Caption = 'Past Injuries';
            FieldClass = FlowField;
            CalcFormula = count("JCA Injury" where(Status = const(Closed), "Member License ID" = field("License ID")));
            Editable = false;
        }
        field(33; Injured; Boolean)
        {
            Caption = 'Injured';
            FieldClass = FlowField;
            CalcFormula = exist("JCA Injury" where(status = const(Open), "Member License ID" = field("License ID")));
            Editable = false;
        }
        field(34; "Send Grouped Result Mails"; Boolean)
        {
            Caption = 'Send Grouped Result Mails';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "License ID")
        { }
        key(AgeGroup1; "Date of Birth")
        { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "License ID", "Full Name")
        { }
    }

    trigger OnInsert()
    var
        JCASetup: Record "JCA Setup";
    begin
        JCASetup.Reset();
        JCASetup.get();
        JCASetup.TestField("Default Membership Code");
        validate("Requested Membership Code", JCASetup."Default Membership Code");
    end;

    trigger OnDelete()
    var
        JCATrainingGroupMember: record "JCA Training Group Member";
        JCAMemberAgeGroup: record "JCA Member Age Group";
        JCAVoucher: Record "JCA Voucher";
        JCAMembershipPeriod: Record "JCA Membership Period";
    begin
        JCATrainingGroupMember.Reset();
        JCATrainingGroupMember.setrange("Member License ID", "License ID");
        JCATrainingGroupMember.deleteall(true);

        JCAMemberAgeGroup.Reset();
        JCAMemberAgeGroup.setrange("Member License ID", "License ID");
        JCAMemberAgeGroup.deleteall(true);

        JCAVoucher.Reset();
        JCAVoucher.Setrange("Issued To No.", rec."License ID");
        JCAVoucher.setrange(Used, false);
        JCAVoucher.deleteall(true);

        JCAMembershipPeriod.Reset();
        JCAMembershipPeriod.setrange("Member License ID", rec."License ID");
        JCAMembershipPeriod.setrange("Membership Payed", false);
        JCAMembershipPeriod.DeleteAll(true);
    end;

    procedure RemoveFromTrainingGroups()
    var
        JCATrainingGroupMember: record "JCA Training Group Member";
    begin
        JCATrainingGroupMember.Reset();
        JCATrainingGroupMember.setrange("Member License ID", "License ID");
        JCATrainingGroupMember.DeleteAll(true);
    end;

    local procedure ManageFullName()
    begin
        "Full Name" := '';
        if ("First Name" <> '') and ("Last Name" <> '') then
            validate("Full Name", "Last Name" + ' ' + "First Name");
    end;

    procedure UpdateAgeGroups(CalculationDate: Date; SaveData: Boolean; var tempJCAMemberAgeGroup: record "JCA Member Age Group" temporary)
    var
        JCAMemberManagement: Codeunit "JCA Member Management";
    begin
        clear(JCAMemberManagement);
        JCAMemberManagement.UpdateAgeGroups(Rec, CalculationDate, SaveData, tempJCAMemberAgeGroup);
    end;

    procedure OpenEventsWithMedal(JCAEventResult: enum "JCA Event Result")
    var
        JCAEventParticipant: record "JCA Event Participant";
        JCAEvent: Record "JCA Event";
        JCAEvents: page "JCA Events";
    begin
        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Member License ID", "License ID");
        JCAEventParticipant.setrange(Result, JCAEventResult);
        if JCAEventParticipant.findset() then
            repeat
                if JCAEvent.Get(JCAEventParticipant."Event No.") then
                    JCAEvent.Mark(true);
            until JCAEventParticipant.Next() = 0;
        JCAEvent.MarkedOnly(true);
        clear(JCAEvents);
        JCAEvents.SetTableView(JCAEvent);
        JCAEvents.run();
    end;

    procedure HasActiveMembership(CheckOnDate: date): Boolean
    var
        JCAMember: record "JCA Member";
    begin
        if CheckOnDate = 0D then
            CheckOnDate := today();
        JCAMember.reset();
        JCAMember.get(Rec."License ID");
        JCAMember.SetFilter("Membersh. Start Date Filter", '<=%1', CheckOnDate);
        JCAMember.SetFilter("Membersh. End Date Filter", '>=%1', CheckOnDate);
        JCAMember.CalcFields("Active Membership");
        exit(JCAMember."Active Membership" <> '');
    end;

    procedure CreateMembershipRenewal()
    var
        JCAMemberManagement: codeunit "JCA Member Management";
    begin
        Clear(JCAMemberManagement);
        JCAMemberManagement.CreateMembershipRenewal(Rec);
    end;

    procedure IssueVoucher(VoucherType: Code[20])
    var
        JCAVoucherManagement: codeunit "JCA Voucher Management";
    begin
        clear(JCAVoucherManagement);
        JCAVoucherManagement.IssueVoucherToMember(Rec, VoucherType);
    end;

    procedure GetPicture(): Text
    var
        TenantMedia: record "Tenant Media";
        Base64Convert: codeunit "Base64 Convert";
        InStream: InStream;
        MemberPicture: Text;
    begin
        MemberPicture := '';
        if Rec.Picture.Count() <> 0 then begin
            TenantMedia.reset();
            TenantMedia.get(Rec.Picture.Item(1));
            TenantMedia.CalcFields(Content);
            TenantMedia.Content.CreateInStream(InStream);
            MemberPicture := Base64Convert.ToBase64(InStream);
        end;
        exit(MemberPicture);
    end;

    var
        tempgJCAMemberAgeGroup: record "JCA Member Age Group" temporary;
}
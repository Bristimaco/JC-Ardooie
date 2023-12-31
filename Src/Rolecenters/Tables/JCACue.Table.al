table 50102 "JCA Cue"
{
    Caption = 'JCA Cue';

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(3; "Active Members"; Integer)
        {
            Caption = 'Active Members';
            FieldClass = FlowField;
            CalcFormula = count("JCA Member" where("Active Membership" = field("Membership Filter"), "Membersh. Start Date Filter" = field("Membersh. Start Date Filter"), "Membersh. End Date Filter" = field("Membersh. End Date Filter")));
            Editable = false;
        }
        field(4; "Inactive Members"; Integer)
        {
            Caption = 'Inactive Members';
            FieldClass = FlowField;
            CalcFormula = count("JCA Member" where("Active Membership" = const(''), "Membersh. Start Date Filter" = field("Membersh. Start Date Filter"), "Membersh. End Date Filter" = field("Membersh. End Date Filter")));
            Editable = false;
        }
        field(5; "Open Training Sessions"; Integer)
        {
            Caption = 'Open Training Sessions';
            FieldClass = FlowField;
            CalcFormula = count("JCA Training Session" where(Status = const(Open)));
            Editable = false;
        }
        field(6; "Closed Training Sessions"; Integer)
        {
            Caption = 'Closed Training Sessions';
            FieldClass = FlowField;
            CalcFormula = count("JCA Training Session" where(Status = const(Closed)));
            Editable = false;
        }
        field(7; "Training Sessions Today"; Integer)
        {
            Caption = 'Training Sessions Today';
            FieldClass = FlowField;
            CalcFormula = count("JCA Training Session" where(Status = const(Open), Date = field("Training Date Filter")));
            Editable = false;
        }
        field(8; "Training Date Filter"; Date)
        {
            Caption = 'Training Date Filter';
            FieldClass = FlowFilter;
        }
        field(9; "New Tournaments"; Integer)
        {
            Caption = 'New';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Tournament), Status = const(New)));
            Editable = false;
        }
        field(10; "New Stages"; Integer)
        {
            Caption = 'New';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Stage), Status = const(New)));
            Editable = false;
        }
        field(11; "New Chiai"; Integer)
        {
            Caption = 'New';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Chiai), Status = const(New)));
            Editable = false;
        }
        field(12; "Tournaments (Inv. Sent)"; Integer)
        {
            Caption = 'Invitation Sent';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Tournament), Status = const("Invitations Sent")));
            Editable = false;
        }
        field(13; "Stages (Inv. Sent)"; Integer)
        {
            Caption = 'Invitation Sent';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Stage), Status = const("Invitations Sent")));
            Editable = false;
        }
        field(14; "Chiai (Inv. Sent)"; Integer)
        {
            Caption = 'Invitation Sent';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Chiai), Status = const("Invitations Sent")));
            Editable = false;
        }
        field(15; "Tournaments (Reg)"; Integer)
        {
            Caption = 'Open for Registrations';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Tournament), Status = const("Open for Registrations")));
            Editable = false;
        }
        field(16; "Stages (Reg))"; Integer)
        {
            Caption = 'Open for Registrations';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Stage), Status = const("Open for Registrations")));
            Editable = false;
        }
        field(17; "Chiai (Reg)"; Integer)
        {
            Caption = 'Open for Registrations';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Chiai), Status = const("Open for Registrations")));
            Editable = false;
        }
        field(18; "Tournaments (RegClosed)"; Integer)
        {
            Caption = 'Registrations Closed';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Tournament), Status = const("Registrations Closed")));
            Editable = false;
        }
        field(19; "Stages (RegClosed))"; Integer)
        {
            Caption = 'Registrations Closed';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Stage), Status = const("Registrations Closed")));
            Editable = false;
        }
        field(20; "Chiai (RegClosed)"; Integer)
        {
            Caption = 'Registrations Closed';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Chiai), Status = const("Registrations Closed")));
            Editable = false;
        }
        field(21; "Tournaments (RegProc)"; Integer)
        {
            Caption = 'Registrations Processed';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Tournament), Status = const("Registrations Processed")));
            Editable = false;
        }
        field(22; "Stages (RegProc))"; Integer)
        {
            Caption = 'Registrations Processed';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Stage), Status = const("Registrations Processed")));
            Editable = false;
        }
        field(23; "Chiai (RecProc)"; Integer)
        {
            Caption = 'Registrations Processed';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Chiai), Status = const("Registrations Processed")));
            Editable = false;
        }
        field(24; "Tournaments (Archived)"; Integer)
        {
            Caption = 'Archived';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Tournament), Status = const(Archived)));
            Editable = false;
        }
        field(25; "Stages (Archived))"; Integer)
        {
            Caption = 'Archived';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Stage), Status = const(Archived)));
            Editable = false;
        }
        field(26; "Chiai (Archived)"; Integer)
        {
            Caption = 'Archived';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Chiai), Status = const(Archived)));
            Editable = false;
        }
        field(27; "Contacts"; Integer)
        {
            Caption = 'Contacts';
            FieldClass = FlowField;
            CalcFormula = count("JCA Contact");
            Editable = false;
        }
        field(28; "Events Today"; Integer)
        {
            Caption = 'Events Today';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Date = field("Event Date Filter")));
            Editable = false;
        }
        field(29; "Event Date Filter"; Date)
        {
            Caption = 'Event Date Filter';
            FieldClass = FlowFilter;
        }
        field(30; "Tournaments (In Progress)"; Integer)
        {
            Caption = 'In Progress';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Tournament), Status = const("In Progress")));
            Editable = false;
        }
        field(31; "Stages (In Progress))"; Integer)
        {
            Caption = 'In Progress';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Stage), Status = const("In Progress")));
            Editable = false;
        }
        field(32; "Chiai (In Progress)"; Integer)
        {
            Caption = 'In Progress';
            FieldClass = FlowField;
            CalcFormula = count("JCA Event" where(Type = const(Chiai), Status = const("In Progress")));
            Editable = false;
        }
        field(33; "Training Sessions to Invoice"; Integer)
        {
            Caption = 'To Invoice';
            FieldClass = FlowField;
            CalcFormula = count("JCA Training Session" where(Status = const(Closed), "Invoice To Customer No." = filter(<> ''), Invoiced = const(false)));
            Editable = false;
        }
        field(34; "Training Sessions Invoiced"; Integer)
        {
            Caption = 'Invoiced';
            FieldClass = FlowField;
            CalcFormula = count("JCA Training Session" where(Status = const(Closed), Invoiced = const(true)));
            Editable = false;
        }
        field(35; "Membership Filter"; Code[20])
        {
            Caption = 'Membership Filter';
            FieldClass = FlowFilter;
        }
        field(36; "Membersh. Start Date Filter"; Date)
        {
            Caption = 'Membership Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(37; "Membersh. End Date Filter"; Date)
        {
            Caption = 'Membership End Date Filter';
            FieldClass = FlowFilter;
        }
        field(38; "Open Membership Payment Req."; Integer)
        {
            Caption = 'Open Membership Payment Requests';
            FieldClass = FlowField;
            CalcFormula = count("JCA Membership Period" where("Membership Payed" = const(false)));
            Editable = false;
        }
        field(39; "Unused Vouchers"; Integer)
        {
            Caption = 'Unused Vouchers';
            FieldClass = FlowField;
            CalcFormula = count("JCA Voucher" where(Used = const(false)));
            Editable = false;
        }
        field(40; "Used Vouchers"; Integer)
        {
            Caption = 'Used Vouchers';
            FieldClass = FlowField;
            CalcFormula = count("JCA Voucher" where(Used = const(true)));
            Editable = false;
        }
        field(41; "Open Injuries"; Integer)
        {
            Caption = 'Open Injuries';
            FieldClass = FlowField;
            CalcFormula = count("JCA Injury" where(Status = const(Open)));
            Editable = false;
        }
        field(42; "Closed Injuries"; Integer)
        {
            Caption = 'Closed Injuries';
            FieldClass = FlowField;
            CalcFormula = count("JCA Injury" where(Status = const(Closed)));
            Editable = false;
        }
        field(43; "Sponsorship Filter"; Code[20])
        {
            Caption = 'Sponsorship Filter';
            FieldClass = FlowFilter;
        }
        field(44; "Sponsorsh. Start Date Filter"; Date)
        {
            Caption = 'Sponsorship Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(45; "Sponsorsh. End Date Filter"; Date)
        {
            Caption = 'Sponsorship End Date Filter';
            FieldClass = FlowFilter;
        }
        field(46; "Open Sponsorship Payment Req."; Integer)
        {
            Caption = 'Open Sponsorship Payment Requests';
            FieldClass = FlowField;
            CalcFormula = count("JCA Sponsorship Period" where("Sponsorship Payed" = const(false)));
            Editable = false;
        }
        field(47; "Active Sponsors"; Integer)
        {
            Caption = 'Active Sponsors';
            FieldClass = FlowField;
            CalcFormula = count(customer where("JCA Sponsor" = const(true), "JCA Active Sponsorship" = field("Sponsorship Filter"), "JCA SpSh. Start Date Filter" = field("Sponsorsh. Start Date Filter"), "JCA SpSh. End Date Filter" = field("Sponsorsh. End Date Filter")));
            Editable = false;
        }
        field(48; "Inactive Sponsors"; Integer)
        {
            Caption = 'Inactive Sponsors';
            FieldClass = FlowField;
            CalcFormula = count(Customer where("JCA Active Sponsorship" = const(''), "JCA SpSh. Start Date Filter" = field("SponsorSh. Start Date Filter"), "JCA SpSh. End Date Filter" = field("Sponsorsh. End Date Filter")));
            Editable = false;
        }        
    }

    keys
    {
        key(PK; Code)
        { }
    }
}
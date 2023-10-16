table 50113 "JCA Event Supervisor"
{
    Caption = 'Event Supervisor';

    fields
    {
        field(1; "Event No."; Code[20])
        {
            Caption = 'Event No.';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Event"."No.";
        }
        field(2; "Member License ID"; Code[20])
        {
            Caption = 'Member License ID';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Member"."License ID" where("Member Type" = filter(Both | Trainer));

            trigger OnValidate()
            begin
                calcfields("Member Full Name");
            end;
        }
        field(3; "Member Full Name"; Text[150])
        {
            Caption = 'Member Full Name';
            FieldClass = FlowField;
            CalcFormula = lookup("JCA Member"."Full Name" where("License ID" = field("Member License ID")));
            Editable = false;
        }
        field(4; Invited; Boolean)
        {
            Caption = 'Invited';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; Registered; Boolean)
        {
            Caption = 'Registered';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(6; "Applied for Registration"; Boolean)
        {
            Caption = 'Applied for Registration';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Event No.", "Member License ID")
        { }
    }

    procedure SendInvitationMail()
    var
        JCAEvent: Record "JCA Event";
        JCAMailManagement: codeunit "JCA Mail Management";
        InvitationSentLbl: Label 'Invitation has been sent';
    begin
        JCAEvent.Reset();
        JCAEvent.Get(Rec."Event No.");
        clear(JCAMailManagement);
        if JCAMailManagement.SendEventInvitationMail(Rec."Member License ID", JCAEvent) then begin
            Rec.Validate(Invited, true);
            rec.Modify(true);
            Message(InvitationSentLbl);
        end;
    end;
}
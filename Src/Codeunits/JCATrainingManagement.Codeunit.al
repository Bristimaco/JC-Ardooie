codeunit 50101 "JCA Training Management"
{
    procedure CreateNewTrainingSession(OpenTrainingSessionCard: Boolean)
    var
        JCATrainingSession: Record "JCA Training Session";
    begin
        JCATrainingSession.Reset();
        JCATrainingSession."No." := '';
        JCATrainingSession.insert(true);
        if OpenTrainingSessionCard then begin
            JCATrainingSession.OpenCard();
        end;
    end;

    procedure CloseTrainingSession(var JCATrainingSession: record "JCA Training Session")
    begin
        JCATrainingSession.Validate(Status, JCATrainingSession.Status::Closed);
        JCATrainingSession.modify(true);
    end;

    procedure FetchTrainingSessionParticipants(var JCATrainingSession: record "JCA Training Session")
    var
        JCATrainingGroupMember: record "JCA Training Group Member";
        JCAGuestMember: record "JCA Member";
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
        JCAClub: record "JCA Club";
    begin
        JCATrainingSession.TestField(Status, JCATrainingSession.Status::Open);
        JCATrainingSession.TestField("Training Group Code");

        JCAClub.Reset();
        JCAClub.setrange("Our Club", true);
        JCAClub.findfirst();

        JCATrainingGroupMember.Reset();
        JCATrainingGroupMember.setrange("Training Group Code", JCATrainingSession."Training Group Code");
        if JCATrainingGroupMember.findset() then
            repeat
                JCATrSessionParticipant.reset();
                JCATrSessionParticipant.setrange("Training Session No.", JCATrainingSession."No.");
                JCATrSessionParticipant.SetRange("Member License ID", JCATrainingGroupMember."Member License ID");
                if JCATrSessionParticipant.IsEmpty() then begin
                    JCATrSessionParticipant.Reset();
                    JCATrSessionParticipant.init();
                    JCATrSessionParticipant.Validate("Participant Type", JCATrSessionParticipant."Participant Type"::Judoka);
                    JCATrSessionParticipant.validate("Club Member", true);
                    JCATrSessionParticipant.validate("Training Session No.", JCATrainingSession."No.");
                    JCATrSessionParticipant.validate("Member License ID", JCATrainingGroupMember."Member License ID");
                    JCATrSessionParticipant.validate("Club No.", JCAClub."No.");
                    JCATrSessionParticipant.insert(true);
                end;
            until JCATrainingGroupMember.Next() = 0;
    end;

    procedure FetchTrainingSupervisors(var JCATrainingSession: record "JCA Training Session")
    var
        JCAMember: record "JCA Member";
        JCAMembers: page "JCA Members";
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
        JCAClub: record "JCA Club";
    begin
        JCAMember.Reset();
        JCAMember.Setfilter("Member Type", '%1|%2', JCAMember."Member Type"::Both, JCAMember."Member Type"::Trainer);

        JCAClub.Reset();
        JCAClub.setrange("Our Club", true);
        JCAClub.findfirst();

        Clear(JCAMembers);
        JCAMembers.SetTableView(JCAMember);
        JCAMembers.LookupMode := true;
        if JCAMembers.RunModal() = action::LookupOK then begin
            JCAMembers.SetSelectionFilter(JCAMember);
            if JCAMember.findset() then
                repeat
                    JCATrSessionParticipant.reset();
                    JCATrSessionParticipant.setrange("Training Session No.", JCATrainingSession."No.");
                    JCATrSessionParticipant.SetRange("Member License ID", JCAMember."License ID");
                    if JCATrSessionParticipant.IsEmpty() then begin
                        JCATrSessionParticipant.Reset();
                        JCATrSessionParticipant.init();
                        JCATrSessionParticipant.Validate("Participant Type", JCATrSessionParticipant."Participant Type"::Trainer);
                        JCATrSessionParticipant.validate("Club Member", true);
                        JCATrSessionParticipant.validate("Training Session No.", JCATrainingSession."No.");
                        JCATrSessionParticipant.validate("Member License ID", JCAMember."License ID");
                        JCATrSessionParticipant.validate("Club No.", JCAClub."No.");
                        JCATrSessionParticipant.insert(true);
                    end;
                until JCAMember.Next() = 0;
        end;
    end;

    procedure FetchTrainingSessionParticipantsFromOtherClubs(var JCATrainingSession: Record "JCA Training Session")
    var
        JCAGuestMemberTrGroup: record "JCA Guest Member Tr. Group";
        JCAGuestMember: record "JCA Guest Member";
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
        JCAClub: record "JCA Club";
    begin
        JCATrainingSession.TestField(Status, JCATrainingSession.Status::Open);
        JCATrainingSession.TestField("Training Group Code");

        JCAGuestMemberTrGroup.Reset();
        JCAGuestMemberTrGroup.setrange("Training Group Code", JCATrainingSession."Training Group Code");
        JCAGuestMemberTrGroup.setrange(Active, true);
        if JCAGuestMemberTrGroup.findset() then
            repeat
                JCAGuestMember.Reset();
                JCAGuestMember.Get(JCAGuestMemberTrGroup."Guest Member License ID");
                if JCAGuestMember.Active then begin
                    JCATrSessionParticipant.reset();
                    JCATrSessionParticipant.setrange("Training Session No.", JCATrainingSession."No.");
                    JCATrSessionParticipant.SetRange("Member License ID", JCAGuestMemberTrGroup."Guest Member License ID");
                    if JCATrSessionParticipant.IsEmpty() then begin
                        JCATrSessionParticipant.Reset();
                        JCATrSessionParticipant.init();
                        JCATrSessionParticipant.validate("Participant Type", JCATrSessionParticipant."Participant Type"::Judoka);
                        JCATrSessionParticipant.validate("Club Member", false);
                        JCATrSessionParticipant.validate("Training Session No.", JCATrainingSession."No.");
                        JCATrSessionParticipant.validate("Member License ID", JCAGuestMemberTrGroup."Guest Member License ID");
                        JCATrSessionParticipant.validate("Club No.", JCAGuestMember."Club No.");
                        JCATrSessionParticipant.insert(true);
                    end;
                end;
            until JCAGuestMemberTrGroup.Next() = 0;
    end;

    procedure ProcessTrainingAttendeeScan(TrainingSessionNo: code[20]; AttendeeLicenseID: code[20])
    var
        JCATrSessionParticipant: record "JCA Tr. Session Participant";
        NotAbleToParticipateErr: label 'You are not registered as a participant for this training, please contact a supervisor.';
        UnRegisterFromTrainingSessionQst: label 'You are already registered for this training session, do you want to unregister?';
    begin
        JCATrSessionParticipant.Reset();
        JCATrSessionParticipant.SetRange("Training Session No.", TrainingSessionNo);
        JCATrSessionParticipant.Setrange("Member License ID", AttendeeLicenseID);
        if not JCATrSessionParticipant.findfirst() then begin
            Message(NotAbleToParticipateErr);
            exit;
        end;

        if JCATrSessionParticipant.Participation then
            if not confirm(UnRegisterFromTrainingSessionQst) then
                exit;

        JCATrSessionParticipant.Participation := not JCATrSessionParticipant.Participation;
        JCATrSessionParticipant.modify(true);
    end;

    procedure OpenTrainingInvoice(var JCATrainingSession: record "JCA Training Session")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header";
        PostedSalesInvoice: page "Posted Sales Invoice";
        SalesInvoice: page "Sales Invoice";
    begin
        case true of
            JCATrainingSession."Posted Invoice No." <> '':
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.setrange("No.", JCATrainingSession."Posted Invoice No.");
                    Clear(PostedSalesInvoice);
                    PostedSalesInvoice.SetTableView(SalesInvoiceHeader);
                    PostedSalesInvoice.run();
                end;
            JCATrainingSession."Invoice No." <> '':
                begin
                    SalesHeader.Reset();
                    SalesHeader.setrange("Document Type", SalesHeader."Document Type"::Invoice);
                    SalesHeader.setrange("No.", JCATrainingSession."Invoice No.");
                    clear(SalesInvoice);
                    SalesInvoice.SetTableView(SalesHeader);
                    SalesInvoice.run();
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure SalesPost_OnAFterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        JCATrainingSession: record "JCA Training Session";
    begin
        if SalesInvHdrNo = '' then
            exit;
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice then
            exit;

        JCATrainingSession.Reset();
        JCATrainingSession.setrange("Invoice No.", SalesHeader."No.");
        if JCATrainingSession.findset() then
            repeat
                JCATrainingSession.validate("Posted Invoice No.", SalesInvHdrNo);
                JCATrainingSession.modify(true);
            until JCATrainingSession.Next() = 0;
    end;

    procedure InvoiceTrainingSession(var JCATrainingSession: Record "JCA Training Session"; OpenInvoiceCard: Boolean)
    var
        ParticipantJCATrSessionParticipant: Record "JCA Tr. Session Participant";
        TrainerJCATrSessionParticipant: record "JCA Tr. Session Participant";
        SalesHeader: Record "Sales Header";
        SalesLine: record "Sales Line";
        JCASetup: Record "JCA Setup";
        LineNo: Integer;
        NoParticipantsToInvoiceErr: label 'No participants to Invoice.';
        NoTrainersToInvoiceErr: label 'No trainers to Invoice';
        TrainersLbl: label 'Trainers:';
        ParticipantsLbl: label 'Participants:';
    begin
        JCATrainingSession.testfield(Invoiced, false);
        JCATrainingSession.TestField("Invoice To Customer No.");

        ParticipantJCATrSessionParticipant.Reset();
        ParticipantJCATrSessionParticipant.setrange("Training Session No.", JCATrainingSession."No.");
        ParticipantJCATrSessionParticipant.setrange(Participation, true);
        ParticipantJCATrSessionParticipant.setrange("Participant Type", ParticipantJCATrSessionParticipant."Participant Type"::Judoka);
        if ParticipantJCATrSessionParticipant.IsEmpty() then
            error(NoParticipantsToInvoiceErr);

        TrainerJCATrSessionParticipant.Reset();
        TrainerJCATrSessionParticipant.setrange("Training Session No.", JCATrainingSession."No.");
        TrainerJCATrSessionParticipant.setrange(Participation, true);
        TrainerJCATrSessionParticipant.setrange("Participant Type", TrainerJCATrSessionParticipant."Participant Type"::Trainer);
        if TrainerJCATrSessionParticipant.IsEmpty() then
            error(NoTrainersToInvoiceErr);

        JCASetup.Reset();
        JCASetup.Get();
        JCASetup.testfield("Training G/L Account No.");
        JCASetup.TestField("Participant Unit Price");

        SalesHeader.Reset();
        SalesHeader.init();
        SalesHeader.validate("Document Type", SalesHeader."Document Type"::Invoice);
        if SalesHeader.insert(true) then begin
            JCATrainingSession.validate("Invoice No.", SalesHeader."No.");
            JCATrainingSession.validate(Invoiced, true);
            JCATrainingSession.modify(true);

            SalesHeader.Validate("Sell-to Customer No.", JCATrainingSession."Invoice To Customer No.");
            SalesHeader.modify(true);

            LineNo := 10000;

            CreateNewInvoiceLine(SalesLine, SalesHeader, LineNo);
            SalesLine.validate(type, SalesLine.Type::" ");
            SalesLine.validate(Description, JCATrainingSession.ReturnTrainingInvoiceDescription());
            SalesLine.modify(true);

            CreateNewInvoiceLine(SalesLine, SalesHeader, LineNo);
            CreateNewInvoiceLine(SalesLine, SalesHeader, LineNo);
            SalesLine.validate(Type, SalesLine.type::" ");
            SalesLine.validate(Description, TrainersLbl);
            SalesLine.modify();

            TrainerJCATrSessionParticipant.findset();
            repeat
                CreateNewInvoiceLine(SalesLine, SalesHeader, LineNo);
                SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
                SalesLine.validate("No.", JCASetup."Training G/L Account No.");
                SalesLine.validate(Description, TrainerJCATrSessionParticipant.ReturnTrainingInvoiceDescription());
                SalesLine.validate(Quantity, 1);
                SalesLine.Validate("Unit Price", JCASetup.""Trainer Unit Price");
                SalesLine.modify();
            until TrainerJCATrSessionParticipant.Next() = 0;

            CreateNewInvoiceLine(SalesLine, SalesHeader, LineNo);
            CreateNewInvoiceLine(SalesLine, SalesHeader, LineNo);
            SalesLine.validate(Type, SalesLine.type::" ");
            SalesLine.validate(Description, ParticipantsLbl);
            SalesLine.modify();

            ParticipantJCATrSessionParticipant.Findset();
            repeat
                CreateNewInvoiceLine(SalesLine, SalesHeader, LineNo);
                SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
                SalesLine.validate("No.", JCASetup."Training G/L Account No.");
                SalesLine.validate(Description, ParticipantJCATrSessionParticipant.ReturnTrainingInvoiceDescription());
                SalesLine.validate(Quantity, 1);
                SalesLine.Validate("Unit Price", JCASetup."Participant Unit Price");
                SalesLine.modify();
            until ParticipantJCATrSessionParticipant.Next() = 0;
        end;

        if OpenInvoiceCard then
            JCATrainingSession.OpenInvoice();
    end;

    local procedure CreateNewInvoiceLine(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; var LineNo: Integer)
    begin
        SalesLine.Reset();
        SalesLine.init();
        SalesLine.validate("Document Type", SalesHeader."Document Type");
        SalesLine.validate("Document No.", SalesHeader."No.");
        SalesLine.validate("Line No.", LineNo);
        SalesLine.insert();
        LineNo += 10000;
    end;
}
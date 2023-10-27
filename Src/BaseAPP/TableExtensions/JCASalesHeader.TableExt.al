tableextension 50101 "JCA Sales Header" extends "Sales Header"
{
    trigger OnAfterDelete()
    var
        JCATrainingSession: record "JCA Training Session";
    begin
        if "Document Type" <> "Document Type"::Invoice then
            exit;

        JCATrainingSession.Reset();
        JCATrainingSession.setrange(Invoiced, true);
        JCATrainingSession.setrange("Invoice No.", "No.");
        if JCATrainingSession.FindSet() then
            repeat
                if JCATrainingSession."Posted Invoice No." = '' then begin
                    JCATrainingSession.validate(Invoiced, false);
                    JCATrainingSession.validate("Invoice No.", '');
                    JCATrainingSession.modify(true);
                end;
            until JCATrainingSession.Next() = 0;
    end;
}
codeunit 50105 "JCA Action Log Management"
{
    procedure LogApplicatonAction(ApplicationAction: enum "JCA Application Action"; Description: Text[250]; RelatedRecordVariant: Variant; RelatedRecordVariant2: Variant)
    var
        JCAActionLog: record "JCA Action Log";
        RecordRef: RecordRef;
    begin
        JCAActionLog.Reset();
        JCAActionLog."Entry No." := 0;
        JCAActionLog.insert(true);
        JCAActionLog.validate("Application Action", ApplicationAction);
        JCAActionLog.validate(Description, Description);

        RecordRef.GetTable(RelatedRecordVariant);
        JCAActionLog.Validate("Related to id", RecordRef.RecordId());
        JCAActionLog.modify(true);

        RecordRef.GetTable(RelatedRecordVariant2);
        JCAActionLog.Validate("Related to id 2", RecordRef.RecordId());
        JCAActionLog.modify(true);
    end;

    procedure LogApplicatonAction(ApplicationAction: enum "JCA Application Action"; Description: Text[250]; RelatedRecordVariant: Variant)
    var
        JCAActionLog: record "JCA Action Log";
        RecordRef: RecordRef;
    begin
        JCAActionLog.Reset();
        JCAActionLog."Entry No." := 0;
        JCAActionLog.insert(true);
        JCAActionLog.validate("Application Action", ApplicationAction);
        JCAActionLog.validate(Description, Description);

        RecordRef.GetTable(RelatedRecordVariant);
        JCAActionLog.Validate("Related to id", RecordRef.RecordId());
        JCAActionLog.modify(true);
    end;
}
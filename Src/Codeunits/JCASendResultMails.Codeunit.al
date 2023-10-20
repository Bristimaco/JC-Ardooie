codeunit 50107 "JCA Send Result Mails"
{
    TableNo = "JCA Event Participant";

    trigger OnRun()
    var
        JCAEventParticipant: record "JCA Event Participant";
        EventNo: code[20];
        MemberLicenseID: code[20];
        JCAEventResult: enum "JCA Event Result";
        Params: Dictionary of [Text, Text];
    begin
        Params := Page.GetBackgroundParameters();
        evaluate(EventNo, Params.Get(JCAEventParticipant.FieldName("Event No.")));
        evaluate(MemberLicenseID, Params.Get(JCAEventParticipant.FieldName("Member License ID")));
        evaluate(JCAEventResult, Params.Get(JCAEventParticipant.FieldName(Result)));

        JCAEventParticipant.Reset();
        JCAEventParticipant.setrange("Event No.", EventNo);
        JCAEventParticipant.setrange("Member License ID", MemberLicenseID);
        if JCAEventParticipant.findfirst() then begin
            JCAEventParticipant.validate(Result, JCAEventResult);
            JCAEventParticipant.SendEventResultMail();
        end;
    end;
}
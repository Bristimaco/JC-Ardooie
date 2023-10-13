codeunit 50102 "JCA Event Management"
{
    procedure CreateNewEvent(OpenEventCard: Boolean)
    var
        JCAEvent: Record "JCA Event";
    begin
        JCAEvent.Reset();
        JCAEvent.ID := 0;
        JCAEvent.insert(true);
        if OpenEventCard then begin
            JCAEvent.OpenCard();
        end;
    end;

    procedure FetchEventParticipants(var JCAEvent: Record "JCA Event")
    var
        JCAEventAgeGroup: Record "JCA Event Age Group";
        JCAMemberAgeGroup: record "JCA Member Age Group";
        JCAAgeGroup: record "JCA Age Group";
        JCAEventParticipant: record "JCA Event Participant";
    begin
        JCAEventAgeGroup.Reset();
        if JCAEventAgeGroup.Findset() then
            repeat
                JCAAgeGroup.Reset();
                JCAAgeGroup.setrange("Country Code", JCAEventAgeGroup."Country Code");
                JCAAgeGroup.setrange(Gender, JCAEventAgeGroup.Gender);
                JCAAgeGroup.setrange(Code, JCAEventAgeGroup."Age Group Code");
                if JCAAgeGroup.findfirst() then
                    if JCAAgeGroup.GetAgeGroupMembers(JCAMemberAgeGroup) then
                        repeat
                            JCAEventParticipant.Reset();
                            JCAEventParticipant.setrange("Event ID", JCAEvent.ID);
                            JCAEventParticipant.setrange("Member License ID", JCAMemberAgeGroup."Member License ID");
                            if JCAEventParticipant.IsEmpty() then begin
                                JCAEventParticipant.Reset();
                                JCAEventParticipant.init();
                                JCAEventParticipant.Validate("Event ID", JCAEvent.ID);
                                JCAEventParticipant.validate("Member License ID", JCAMemberAgeGroup."Member License ID");
                                JCAEventParticipant.Validate("Age Group Code", JCAMemberAgeGroup."Age Group Code");
                                JCAEventParticipant.insert(true);
                            end;
                        until JCAMemberAgeGroup.Next() = 0;
            until JCAEventAgeGroup.Next() = 0;
    end;
}
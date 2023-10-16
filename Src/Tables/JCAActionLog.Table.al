table 50116 "JCA Action Log"
{
    Caption = 'Action Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Application Action"; enum "JCA Application Action")
        {
            Caption = 'Application Action';
            DataClassification = SystemMetadata;
        }
        field(3; Description; text[250])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(4; "Logged on"; DateTime)
        {
            Caption = 'Logged on';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5; "Logged by"; Code[50])
        {
            Caption = 'Logged by';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(6; "Related to Id"; RecordId)
        {
            Caption = 'Related to id';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(7; "Related to Id 2"; RecordId)
        {
            Caption = 'Related to Id 2';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        { }
    }

    trigger OnInsert()
    begin
        validate("Logged by", UserId());
        Validate("Logged on", CurrentDateTime());
    end;

    procedure OpenRelatedObjects()
    var
        RecordRef: RecordRef;
    begin
        if RecordRef.get("Related to id") then
            OpenRelatedObject(RecordRef);
        if RecordRef.get("Related to id 2") then
            OpenRelatedObject(RecordRef);
    end;

    local procedure OpenRelatedObject(var RecordRef: RecordRef)
    var
        JCAEvent: record "JCA Event";
        JCAMember: record "JCA Member";
        JCAEventCard: Page "JCA Event Card";
        JCAMemberCard: page "JCA Member Card";
    begin
        case RecordRef.Number of
            database::"JCA Event":
                begin
                    RecordRef.SetTable(JCAEvent);
                    JCAEvent.SetRecFilter();
                    clear(JCAEventCard);
                    JCAEventCard.SetTableView(JCAEvent);
                    JCAEventCard.Run();
                end;
            Database::"JCA Member":
                begin
                    RecordRef.SetTable(JCAMember);
                    JCAMember.SetRecFilter();
                    clear(JCAMemberCard);
                    JCAMemberCard.SetTableView(JCAMember);
                    JCAMemberCard.Run();
                end;
        end;
    end;
}
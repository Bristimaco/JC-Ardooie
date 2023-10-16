page 50127 "JCA Event Supervisor Sheet"
{
    Caption = 'Event Supervisor Sheet';
    SourceTable = "JCA Event Participant";
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            field(AgeGroup; AgeGroup)
            {
                Caption = 'Age Group Filter';
                ApplicationArea = all;

                trigger OnAssistEdit()
                var
                    JCAEventAgeGroup: record "JCA Event Age Group";
                    JCAEventAgeGroupLookup: page "JCA Event Age Group Lookup";
                begin
                    JCAEventAgeGroup.Reset();
                    JCAEventAgeGroup.setrange("Event No.", Rec."Event No.");
                    clear(JCAEventAgeGroupLookup);
                    JCAEventAgeGroupLookup.SetTableView(JCAEventAgeGroup);
                    JCAEventAgeGroupLookup.LookupMode := true;
                    if JCAEventAgeGroupLookup.RunModal() = action::LookupOK then begin
                        JCAEventAgeGroupLookup.GetRecord(JCAEventAgeGroup);
                        Rec.SetRange(Gender, JCAEventAgeGroup.Gender);
                        Rec.SetRange("Age Group Code", JCAEventAgeGroup."Age Group Code");
                        AgeGroup := JCAEventAgeGroup."Age Group Code";
                        Gender := format(JCAEventAgeGroup.Gender);
                        CurrPage.update(false);
                    end;
                end;

                trigger OnValidate()
                begin
                    Rec.Setrange(Gender);
                    Rec.setrange("Age Group Code");

                    AgeGroup := '';
                    Gender := '';

                    CurrPage.Update(false);
                end;
            }
            field(Gender; Gender)
            {
                ApplicationArea = all;
                Caption = 'Gender';
                Editable = false;
            }
            repeater(EventParticipants)
            {
                field("No-Show"; Rec."No-Show")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("Age Group Code"; Rec."Age Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                Field("Member Full Name"; Rec."Member Full Name")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                Field(Result; Rec.Result)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;

                    trigger OnValidate()
                    begin
                        if xRec.Result <> rec.Result then
                            Rec.SendEventResultMail();
                    end;
                }
            }
        }
    }

    var
        AgeGroup: Code[20];
        Gender: text;
}
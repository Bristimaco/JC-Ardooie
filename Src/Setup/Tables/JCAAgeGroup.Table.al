table 50104 "JCA Age Group"
{
    Caption = 'Age Group';

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; Gender; enum "JCA Gender")
        {
            Caption = 'Gender';
            DataClassification = SystemMetadata;
        }
        field(3; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region".Code;
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(5; "Maximum Age"; Integer)
        {
            Caption = 'Max. Age';
            DataClassification = SystemMetadata;
        }
        field(6; "Minimum Age"; Integer)
        {
            Caption = 'Min. Age';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; Code, "Country Code", Gender)
        { }
        key(AgeGroupUpdate; "Country Code", Gender, "Maximum Age")
        { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; code, Description)
        { }
    }

    procedure GetAgeGroupMembers(var tempJCAMemberAgeGroup: Record "JCA Member Age Group" temporary; CalculateAtDate: Date): Boolean
    var
        JCAMember: record "JCA Member";
        tempMemberJCAMemberAgeGroup: record "JCA Member Age Group" temporary;
    begin
        if CalculateAtDate = 0D then
            exit;

        tempJCAMemberAgeGroup.Reset();
        tempJCAMemberAgeGroup.DeleteAll();

        JCAMember.Reset();
        if JCAMember.FindSet() then
            repeat
                tempMemberJCAMemberAgeGroup.reset();
                tempMemberJCAMemberAgeGroup.deleteall();
                JCAMember.UpdateAgeGroups(CalculateAtDate, false, tempMemberJCAMemberAgeGroup);

                tempMemberJCAMemberAgeGroup.setrange("Age Group Code", rec.Code);
                tempMemberJCAMemberAgeGroup.setrange("Country Code", rec."Country Code");
                tempMemberJCAMemberAgeGroup.setrange(Gender, Rec.Gender);
                if tempMemberJCAMemberAgeGroup.findset() then
                    repeat
                        tempJCAMemberAgeGroup.reset();
                        tempJCAMemberAgeGroup.init();
                        tempJCAMemberAgeGroup.TransferFields(tempMemberJCAMemberAgeGroup);
                        tempJCAMemberAgeGroup.insert();
                    until tempMemberJCAMemberAgeGroup.Next() = 0;
            until JCAMember.Next() = 0;

        exit(tempJCAMemberAgeGroup.findset());
    end;
}
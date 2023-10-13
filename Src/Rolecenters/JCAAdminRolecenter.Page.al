page 50103 "JCA Admin Rolecenter"
{
    Caption = 'Admin Rolecenter';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Members; "JCA Member Cues")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action(Countries)
            {
                Caption = 'Countries';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "Countries/Regions";
                Image = CountryRegion;
            }
            action(AgeGroups)
            {
                Caption = 'Age Groups';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Age Groups";
                Image = Group;
            }
            action(WeightGroups)
            {
                Caption = 'Weight Groups';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Weight Groups";
                Image = Group;
            }
        }
    }
}
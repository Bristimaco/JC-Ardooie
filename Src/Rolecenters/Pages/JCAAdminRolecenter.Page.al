page 50103 "JCA Admin Rolecenter"
{
    Caption = 'Admin Rolecenter';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Today; "JCA Today Cues")
            {
                Caption = 'Today';
                ApplicationArea = all;
            }
            part(TrainingSessions; "JCA Training Session Cues")
            {
                Caption = 'Training Sessions';
                ApplicationArea = all;
            }
            part(Events; "JCA Event Cues")
            {
                Caption = 'Events';
                ApplicationArea = all;
            }
            part(Members; "JCA Member Cues")
            {
                Caption = 'Members';
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action(Setup)
            {
                Caption = 'Setup';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Setup";
                Image = Setup;
            }

            action(sponsors)
            {
                Caption = 'Sponsors';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "Customer List";
                RunPageView = where("JCA Sponsor" = const(true));
                Image = Vendor;
            }

            action(OurMembers)
            {
                Caption = 'Members';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Members";
                Image = Group;
            }
            action(GuestMembers)
            {
                Caption = 'Guest Members';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Guest Members";
                Image = Group;
            }
            action(TrainingSessionList)
            {
                Caption = 'Training Sessions';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Training Sessions";
                Image = History;
            }
            action(EventList)
            {
                Caption = 'Events';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "JCA Events";
                Image = History;
            }
            action(Items)
            {
                Caption = 'Items';
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
                RunObject = page "Item List";
                Image = Item;
            }
        }
    }
}
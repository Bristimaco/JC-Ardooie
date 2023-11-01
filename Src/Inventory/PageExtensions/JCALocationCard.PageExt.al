pageextension 50106 "JCA Location Card" extends "Location Card"
{
    layout
    {
        modify("Use As In-Transit")
        {
            Visible = false;
        }
        modify("Address 2")
        {
            Visible = false;
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify("Branch No.")
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(Bins)
        {
            Visible = false;
        }
        modify("Bin Policies")
        {
            Visible = false;
        }
    }

    actions
    {
        modify("Online Map")
        {
            Visible = false;
        }
        modify("&Resource Locations")
        {
            Visible = false;
        }
        modify("&Zones")
        {
            Visible = false;
        }
        modify("&Bins")
        {
            Visible = false;
        }
        modify("Warehouse Employees")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
    }
}
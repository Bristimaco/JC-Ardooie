pageextension 50100 "JCA Countries/Regions" extends "Countries/Regions"
{
    layout
    {
        addlast(Control1)
        {
            field("JCA Age Group Switch Month"; Rec."JCA Age Group Switch Month")
            {
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
            }
        }

        modify("ISO Code")
        {
            Visible = false;
        }
        modify("ISO Numeric Code")
        {
            Visible = false;
        }
        modify("SEPA Allowed")
        {
            Visible = false;
        }
        modify("EU Country/Region Code")
        {
            Visible = false;
        }
        modify("Address Format")
        {
            Visible = false;
        }
        modify("Contact Address Format")
        {
            Visible = false;
        }
        modify("County Name")
        {
            Visible = false;
        }
        modify("Intrastat Code")
        {
            Visible = false;
        }
        modify("IBAN Country/Region")
        {
            Visible = false;
        }
        modify("VAT Scheme")
        {
            Visible = false;
        }
    }
}
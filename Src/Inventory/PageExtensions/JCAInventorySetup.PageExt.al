pageextension 50108 "JCA Inventory Setup" extends "Inventory Setup"
{
    layout
    {
        modify("Expected Cost Posting to G/L")
        {
            Visible = false;
        }
        modify("Outbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Variant Mandatory if Exists")
        {
            Visible = false;
        }
        modify("Skip Prompt to Create Item")
        {
            Visible = false;
        }
        modify("Item Group Dimension Code")
        {
            Visible = false;
        }
        modify("Posted Direct Trans. Nos.")
        {
            Visible = false;
        }
        modify("Nonstock Item Nos.")
        {
            Visible = false;
        }
        modify("Transfer Order Nos.")
        {
            Visible = false;
        }
        modify("Posted Transfer Shpt. Nos.")
        {
            Visible = false;
        }
        modify("Posted Transfer Rcpt. Nos.")
        {
            Visible = false;
        }
        modify("Direct Transfer Posting")
        {
            Visible = false;
        }
        modify("Inventory Put-away Nos.")
        {
            Visible = false;
        }
        modify("Posted Invt. Put-away Nos.")
        {
            Visible = false;
        }
        modify("Inventory Pick Nos.")
        {
            Visible = false;
        }
        modify("Posted Invt. Pick Nos.")
        {
            Visible = false;
        }
        modify("Inventory Movement Nos.")
        {
            Visible = false;
        }
        modify("Registered Invt. Movement Nos.")
        {
            Visible = false;
        }
        modify("Internal Movement Nos.")
        {
            Visible = false;
        }
        modify("Phys. Invt. Order Nos.")
        {
            Visible = false;
        }
        modify("Posted Phys. Invt. Order Nos.")
        {
            Visible = false;
        }
        modify("Posted Invt. Receipt Nos.")
        {
            Visible = false;
        }
        modify("Invt. Shipment Nos.")
        {
            Visible = false;
        }
        modify("Posted Invt. Shipment Nos.")
        {
            Visible = false;
        }
        modify("Invt. Receipt Nos.")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        movelast(General; "Item Nos.")
        movelast(General; "Invt. Cost Jnl. Template Name")
        movelast(General; "Invt. Cost Jnl. Batch Name")
        modify("Gen. Journal Templates")
        {
            Visible = false;
        }
        movelast(General; "Location Mandatory")
        modify(Location)
        {
            Visible = false;
        }
        modify(Numbering)
        {
            Visible = false;
        }
    }
    actions
    {
        modify("Schedule Cost Adjustment and Posting_Promoted")
        {
            Visible = false;
        }
        modify("Item Discount Groups_Promoted")
        {
            Visible = false;
        }
        modify("Import Item Pictures_Promoted")
        {
            Visible = false;
        }
        modify("Schedule Cost Adjustment and Posting")
        {
            Visible = false;
        }
        modify("Item Discount Groups")
        {
            Visible = false;
        }
        modify("Import Item Pictures")
        {
            Visible = false;
        }
    }
}
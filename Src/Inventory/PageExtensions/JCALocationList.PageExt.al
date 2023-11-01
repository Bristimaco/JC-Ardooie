pageextension 50105 "JCA Location List" extends "Location List"
{
    actions
    {
        modify("&Location")
        {
            Visible = false;
        }
        modify(Category_Report)
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("Create Warehouse location")
        {
            Visible = false;
        }
        modify(DimensionsMultiple)
        {
            Visible = false;
        }
        modify("Transfer Order")
        {
            Visible = false;
        }
        modify("Inventory - Inbound Transfer")
        {
            Visible = false;
        }
        modify("Transfer Receipt")
        {
            Visible = false;
        }
        modify("Transfer Shipment")
        {
            Visible = false;
        }
        modify("Items with Negative Inventory")
        {
            Visible = false;
        }
        modify(Action1907283206)
        {
            Visible = false;
        }
    }
}
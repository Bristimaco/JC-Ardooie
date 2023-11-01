pageextension 50107 "JCA Item List" extends "Item List"
{
    layout
    {
        modify(Type)
        {
            Visible = false;
        }
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify(Control1901314507)
        {
            Visible = false;
        }
        modify(Control1903326807)
        {
            Visible = false;
        }
        modify(Control1906840407)
        {
            Visible = false;
        }
        modify(Control1901796907)
        {
            Visible = false;
        }
        modify(PowerBIEmbeddedReportPart)
        {
            Visible = false;
        }
    }

    actions
    {
        modify(CopyItem_Promoted)
        {
            Visible = false;
        }
        modify(Category_Category7)
        {
            Visible = false;
        }
        modify(Category_Process)
        {
            Visible = false;
        }
        modify(Category_Dimensions)
        {
            Visible = false;
        }
        modify(ApprovalEntries_Promoted)
        {
            Visible = false;
        }
        modify(Action16_Promoted)
        {
            Visible = false;
        }
        modify("Items b&y Location_Promoted")
        {
            Visible = false;
        }
        modify(Structure_Promoted)
        {
            Visible = false;
        }
        modify("Cost Shares_Promoted")
        {
            Visible = false;
        }
        modify("<Action5>_Promoted")
        {
            Visible = false;
        }
        modify("BOM Level_Promoted")
        {
            Visible = false;
        }
        modify(Period_Promoted)
        {
            Visible = false;
        }
        modify(Variant_Promoted)
        {
            Visible = false;
        }
        modify(Lot_Promoted)
        {
            Visible = false;
        }
        modify("Unit of Measure_Promoted")
        {
            Visible = false;
        }
        modify("Item Refe&rences_Promoted")
        {
            Visible = false;
        }
        moveafter(Category_Process; Location_Promoted)
        modify(Category_Report)
        {
            Visible = false;
        }
        modify(Action126)
        {
            Visible = false;
        }
        modify(Availability)
        {
            Visible = false;
        }
        modify("Assembly/Production")
        {
            Visible = false;
        }
        modify(Sales)
        {
            Visible = false;
        }
        modify(Purchases)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(Service)
        {
            Visible = false;
        }
        modify(Resources)
        {
            Visible = false;
        }
        modify(PrintLabel)
        {
            Visible = false;
        }
        modify(AssemblyProduction)
        {
            Visible = false;
        }
        modify(Inventory)
        {
            Visible = false;
        }
        modify(Orders)
        {
            Visible = false;
        }
        modify("&Phys. Inventory Ledger Entries")
        {
            Visible = false;
        }
        modify("&Reservation Entries")
        {
            Visible = false;
        }
        modify("&Value Entries")
        {
            Visible = false;
        }
        modify("Item &Tracking Entries")
        {
            Visible = false;
        }
        modify("&Warehouse Entries")
        {
            Visible = false;
        }
        addfirst(Category_Category4)
        {
            actionref("Ledger E&ntries_Promoted23785"; "Ledger E&ntries")
            {
            }
        }
        modify(PricesandDiscounts)
        {
            Visible = false;
        }
        modify(PurchPricesandDiscounts)
        {
            Visible = false;
        }
        modify(PeriodicActivities)
        {
            Visible = false;
        }
        modify(RequestApproval)
        {
            Visible = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify(Functions)
        {
            Visible = false;
        }
        modify("Requisition Worksheet")
        {
            Visible = false;
        }
        modify("Item Journal")
        {
            Visible = false;
        }
        modify("Item Reclassification Journal")
        {
            Visible = false;
        }
        modify("Item Tracing")
        {
            Visible = false;
        }
        modify("Adjust Item Cost/Price")
        {
            Visible = false;
        }
        modify(ApplyTemplate)
        {
            Visible = false;
        }
    }
}
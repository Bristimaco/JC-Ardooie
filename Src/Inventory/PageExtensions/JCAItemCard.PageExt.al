pageextension 50109 "JCA Item Card" extends "Item Card"
{
    layout
    {
        modify(ForeignTrade)
        {
            Visible = false;
        }
        modify(Replenishment_Assembly)
        {
            Visible = false;
        }
        modify(Replenishment_Production)
        {
            Visible = false;
        }
        modify(ItemTracking)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(GTIN)
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify(VariantMandatoryDefaultNo)
        {
            Visible = false;
        }
        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("Created From Nonstock Item")
        {
            Visible = false;
        }
        modify("Qty. on Job Order")
        {
            Visible = false;
        }
        modify("Qty. on Assembly Order")
        {
            Visible = false;
        }
        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify("Net Weight")
        {
            Visible = false;
        }
        modify("Unit Volume")
        {
            Visible = false;
        }
        modify("Gross Weight")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify(EntityTextFactBox)
        {
            Visible = false;
        }
        modify("Tariff No.")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Assembly Policy")
        {
            Visible = false;
        }
        modify("Price Includes VAT")
        {
            Visible = false;
        }
        modify("Item Disc. Group")
        {
            Visible = false;
        }
        modify("Allow Invoice Disc.")
        {
            Visible = false;
        }
        modify(AssemblyBOM)
        {
            Visible = false;
        }
        modify("Overhead Rate")
        {
            Visible = false;
        }
        modify("Stockkeeping Unit Exists")
        {
            Visible = false;
        }
        modify(Critical)
        {
            Visible = false;
        }
        modify("Safety Lead Time")
        {
            Visible = false;
        }
        modify("Include Inventory")
        {
            Visible = false;
        }
        modify("Lot Accumulation Period")
        {
            Visible = false;
        }
        modify("Rescheduling Period")
        {
            Visible = false;
        }
        modify("Item Tracking Code")
        {
            Visible = false;
        }
        modify("Lot Nos.")
        {
            Visible = false;
        }
        modify("Serial Nos.")
        {
            Visible = false;
        }
        modify("Expiration Calculation")
        {
            Visible = false;
        }
        modify(Reserve)
        {
            Visible = false;
        }
        modify("Order Tracking Policy")
        {
            Visible = false;
        }
        modify("Dampener Period")
        {
            Visible = false;
        }
        modify("Dampener Quantity")
        {
            Visible = false;
        }
        modify("Overflow Level")
        {
            Visible = false;
        }
        modify("Time Bucket")
        {
            Visible = false;
        }
        modify("Warehouse Class Code")
        {
            Visible = false;
        }
        modify("Special Equipment Code")
        {
            Visible = false;
        }
        modify("Put-away Template Code")
        {
            Visible = false;
        }
        modify("Put-away Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Phys Invt Counting Period Code")
        {
            Visible = false;
        }
        modify("Last Counting Period Update")
        {
            Visible = false;
        }
        modify("Last Phys. Invt. Date")
        {
            Visible = false;
        }
        modify("Next Counting Start Date")
        {
            Visible = false;
        }
        modify("Next Counting End Date")
        {
            Visible = false;
        }
        modify("Use Cross-Docking")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Category_Category8)
        {
            Visible = false;
        }
        modify(Category_Category7)
        {
            Visible = false;
        }
        modify(CopyItem_Promoted)
        {
            Visible = false;
        }
        modify(AdjustInventory_Promoted)
        {
            Visible = false;
        }
        modify(ApplyTemplate_Promoted)
        {
            Visible = false;
        }
        modify(Statistics_Promoted)
        {
            Visible = false;
        }
        modify(ApprovalEntries_Promoted)
        {
            Visible = false;
        }
        modify("&Phys. Inventory Ledger Entries_Promoted")
        {
            Visible = false;
        }
        modify(Dimensions_Promoted)
        {
            Visible = false;
        }
        modify(EditMarketingText_Promoted)
        {
            Visible = false;
        }
        modify("Category_Item Availability by")
        {
            Visible = false;
        }
        modify(BOMStructure_Promoted)
        {
            Visible = false;
        }
        modify(ItemsByLocation_Promoted)
        {
            Visible = false;
        }
        modify("Cost Shares_Promoted")
        {
            Visible = false;
        }
        modify(PricesandDiscounts)
        {
            Visible = false;
        }
        modify(PurchPricesandDiscounts)
        {
            Visible = false;
        }
        modify(Approval)
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
        modify("&Create Stockkeeping Unit")
        {
            Visible = true;
        }
        modify(CalculateCountingPeriod)
        {
            Visible = false;
        }
        modify(Templates)
        {
            Visible = false;
        }
        modify(ApplyTemplate)
        {
            Visible = false;
        }
        modify(SaveAsTemplate)
        {
            Visible = false;
        }
        modify(CopyItem)
        {
            Visible = false;
        }
        modify(AdjustInventory)
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
        addafter(Category_Category4)
        {
            actionref("Ledger E&ntries_Promoted04992"; "Ledger E&ntries")
            {
            }
        }
        modify(History)
        {
            Visible = false;
        }
        modify(Navigation_Item)
        {
            Visible = false;
        }
        modify(Availability)
        {
            Visible = false;
        }
        modify("Prepa&yment Percentages")
        {
            Visible = false;
        }
        modify("Return Orders")
        {
            Visible = false;
        }
        modify(Sales)
        {
            Visible = false;
        }
        modify(BillOfMaterials)
        {
            Visible = false;
        }
        modify(Navigation_Warehouse)
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
    }
}

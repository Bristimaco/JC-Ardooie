pageextension 50102 "JCA Customers" extends "Customer List"
{
    layout
    {
        addafter("No.")
        {
            field(Sponsor; Rec."JCA Sponsor")
            {
                ApplicationArea = all;
                ToolTip = ' ', Locked = true;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
    }

    actions
    {
        modify("&Customer")
        {
            Visible = false;
        }
        modify(ActionGroupCRM)
        {
            Visible = false;
        }
        modify(History)
        {
            Visible = false;
        }
        modify(Documents)
        {
            Visible = false;
        }
        modify(Service)
        {
            Visible = false;
        }
        modify(NewSalesQuote)
        {
            Visible = false;
        }
        modify(NewSalesInvoice)
        {
            Visible = false;
        }
        modify(NewSalesOrder)
        {
            Visible = false;
        }
        modify(NewSalesReturnOrder)
        {
            Visible = false;
        }
        modify(NewServiceQuote)
        {
            Visible = false;
        }
        modify(NewServiceInvoice)
        {
            Visible = false;
        }
        modify(NewServiceOrder)
        {
            Visible = false;
        }
        modify(NewReminder)
        {
            Visible = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify("Sales Journal")
        {
            Visible = false;
        }
        modify(PaymentRegistration)
        {
            Visible = false;
        }
        modify(WordTemplate)
        {
            Visible = false;
        }
        modify(Email)
        {
            Visible = false;
        }
        modify(BackgroundStatement)
        {
            Visible = false;
        }
        modify(Category_Process)
        {
            Visible = false;
        }
        modify(Category_Category5)
        {
            Visible = false;
        }
        modify(Category_Category6)
        {
            Visible = false;
        }
        modify(Category_Category4)
        {
            Visible = false;
        }
        modify(Category_Category7)
        {
            Visible = false;
        }
        modify(Category_Category8)
        {
            Visible = false;
        }
        modify(Category_Category9)
        {
            Visible = false;
        }
        modify(Category_Report)
        {
            Visible = false;
        }
        modify(Category_Synchronize)
        {
            Visible = false;
        }
        modify(PricesAndDiscounts)
        {
            Visible = false;
        }
        modify(Category_New)
        {
            Visible = false;
        }
        modify(NewSalesBlanketOrder)
        {
            Visible = false;
        }
        modify(NewSalesCrMemo)
        {
            Visible = false;
        }
        modify(NewFinChargeMemo)
        {
            Visible = false;
        }
        modify("Cash Receipt Journal")
        {
            Visible = false;
        }
        modify(ApplyTemplate)
        {
            Visible = false;
        }
        modify(Sales)
        {
            Visible = false;
        }
        modify(Reports)
        {
            Visible = false;
        }
        modify("Prepa&yment Percentages")
        {
            Visible = false;
        }
        modify("Recurring Sales Lines")
        {
            Visible = false;
        }
        modify("Customer List")
        {
            Visible = false;
        }
        modify("Customer Register")
        {
            Visible = false;
        }
        modify("Customer - Top 10 List")
        {
            Visible = false;
        }
    }
}
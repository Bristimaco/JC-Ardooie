pageextension 50101 "JCA Customer Card" extends "Customer Card"
{
    layout
    {
        addafter("No.")
        {
            group(Sponsoring)
            {
                field(Sponsor; Rec."JCA Sponsor")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("JCA Sponsor Formula"; Rec."JCA Sponsor Formula")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
                field("JCA Sponsor Form. Descr."; Rec."JCA Sponsor Form. Descr.")
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify(BalanceAsVendor)
        {
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Balance (LCY)2")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify(TotalSales2)
        {
            Visible = false;
        }
        modify("CustSalesLCY - CustProfit - AdjmtCostLCY")
        {
            Visible = false;
        }
        modify(AdjCustProfit)
        {
            Visible = false;
        }
        modify(AdjProfitPct)
        {
            Visible = false;
        }
        moveafter("Enterprise No."; "VAT Registration No.")
        modify("VAT Liable")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        modify("EORI Number")
        {
            Visible = false;
        }
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        modify("Copy Sell-to Addr. to Qte From")
        {
            Visible = false;
        }
        modify(PricesandDiscounts)
        {
            Visible = false;
        }
        moveafter("VAT Registration No."; "Payment Terms Code")
        modify(Payments)
        {
            Visible = false;
        }
        modify(Shipping)
        {
            Visible = false;
        }
        modify(Statistics)
        {
            Visible = false;
        }
        modify(ContactDetails)
        {
            Visible = false;
        }
        modify("Bill-to Customer No.")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Registration Number")
        {
            Visible = false;
        }
        moveafter("Payment Terms Code"; "Gen. Bus. Posting Group")
        moveafter("Gen. Bus. Posting Group"; "VAT Bus. Posting Group")
        moveafter("VAT Bus. Posting Group"; "Customer Posting Group")
        modify(Invoicing)
        {
            Visible = false;
        }
        modify(Control1905532107)
        {
            Visible = false;
        }
        modify("Format Region")
        {
            Visible = false;
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify(CustomerStatisticsFactBox)
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
        modify("Prices and Discounts")
        {
            Visible = false;
        }
        modify(Action82)
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
        modify(NewBlanketSalesOrder)
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
        modify(NewSalesCreditMemo)
        {
            Visible = false;
        }
        modify(NewSalesQuoteAddin)
        {
            Visible = false;
        }
        modify(NewSalesInvoiceAddin)
        {
            Visible = false;
        }
        modify(NewSalesOrderAddin)
        {
            Visible = false;
        }
        modify(NewSalesCreditMemoAddin)
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
        modify(NewServiceCreditMemo)
        {
            Visible = false;
        }
        modify(NewReminder)
        {
            Visible = false;
        }
        modify(NewFinanceChargeMemo)
        {
            Visible = false;
        }
        modify(Approval)
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
        modify("F&unctions")
        {
            Visible = false;
        }
        modify("Post Cash Receipts")
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
        modify("Report Customer Detailed Aging")
        {
            Visible = false;
        }
        modify("Report Customer - Labels")
        {
            Visible = false;
        }
        modify("Report Customer - Balance to Date")
        {
            Visible = false;
        }
        modify("Report Statement")
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
    }
}
class Revenue
  def initialize(revenue)
    @id = nil
    @revenue = revenue
  end

  def self.total_revenue_for_timespan(params)
    revenue = Invoice.joins(:invoice_items, :transactions).merge(Transaction.where(result: 'success')).where('invoices.created_at BETWEEN ? AND ?', params[:start], params[:end]).sum('quantity * unit_price')
    # test = InvoiceItem.select(sum(invoice_items.quantity*invoice_items.unit_price) as revenue").joins(:invoice).where('invoices.created_at BETWEEN ? AND ?', params[:start], params[:end]).where("transactions.result ='success'").sum(invoice_items.quantity*invoice_items.unit_price)
    new revenue
  end
end

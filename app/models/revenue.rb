class Revenue
  attr_reader :id,
              :revenue
  def initialize(revenue = nil)
    @id = nil
    @revenue = revenue
  end

  def self.total_revenue_for_timespan(params)
  first_day = Date.parse(params[:start]).beginning_of_day
  last_day = Date.parse(params[:end]).end_of_day
  total_revenue = Invoice.joins(:invoice_items, :transactions)
                     .merge(Transaction.where(result: 'success'))
                     .where('date(invoices.created_at) BETWEEN ? AND ?', first_day, last_day)
                     .sum('quantity * unit_price')

  new (total_revenue)
  end
end

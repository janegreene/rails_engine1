class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates :name, presence: true

  def self.most_revenue(params)
    Merchant.select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue").joins(invoices:[:invoice_items, :transactions]).where("transactions.result='success'").group("merchants.id").order("revenue desc").limit(params[:quantity])
  end

  def self.most_items(params)
    Merchant.select("merchants.*, sum(invoice_items.quantity) as total_items").joins(invoices:[:invoice_items, :transactions]).where("transactions.result='success'").group("merchants.id").order("total_items desc").limit(params[:quantity])
  end

  # def self.total_revenue(params)
  #   test = InvoiceItem.select(sum(invoice_items.quantity*invoice_items.unit_price) as revenue").joins(:invoice).where('invoices.created_at BETWEEN ? AND ?', params[:start], params[:end]).where("transactions.result ='success'").sum(invoice_items.quantity*invoice_items.unit_price)
  # end
end

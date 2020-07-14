require 'csv'

desc "Tear down and Import models from csv files"

task :import => [:environment] do
  models = [Transaction, InvoiceItem, Invoice, Item, Merchant, Customer]
  models.each do |model|
    model.destroy_all
    puts "#{model} objects destroyed"
  end

  file = "./data/customers.csv"
  CSV.foreach(file, headers: true) do |row|
    Customer.create!(row.to_hash)
  end

  file = "./data/merchants.csv"
  CSV.foreach(file, headers: true) do |row|
    Merchant.create!(row.to_hash)
  end

  file = "./data/items.csv"
  CSV.foreach(file, headers: true) do |row|
    Item.create!({
      id:          row[0],
      name:        row[1],
      description: row[2],
      unit_price:  row[3].to_f / 100,
      merchant_id: row[4],
      created_at:  row[5],
      updated_at:  row[6]
      })
  end

  file = "./data/invoices.csv"
  CSV.foreach(file, headers: true) do |row|
    Invoice.create!(row.to_hash)
  end

  file = "./data/invoice_items.csv"
  CSV.foreach(file, headers: true) do |row|
    InvoiceItem.create!({
      id:          row[0],
      item_id:    row[1],
      invoice_id: row[2],
      quantity:   row[3],
      unit_price:  row[4].to_f / 100,
      created_at: row[5],
      updated_at: row[6]
      })
  end

  file = "./data/transactions.csv"
  CSV.foreach(file, headers: true) do |row|
    Transaction.create!({
       id:                          row[0],
       invoice_id:                  row[1],
       credit_card_number:          row[2],
       # credit_card_expiration_date: row[3],
       result:                      row[4],
       created_at:                  row[5],
       updated_at:                  row[6]
      })
  end


  models.each do |model|
    total = model.all.count
    puts "#{total} #{model} objects created"
  end

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

   puts "Seed from CSV Complete."
end

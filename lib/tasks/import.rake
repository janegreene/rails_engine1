require 'csv'

desc "Tear down and Import models from csv files"

task :import => [:environment] do
  models = [Transaction, InvoiceItem, Invoice, Item, Merchant, Customer]
  models.each do |model|
    model.destroy_all
    puts "#{model} objects destroyed"
    ActiveRecord::Base.connection.reset_pk_sequence!(model.table_name)
  end

  file = "./data/customers.csv"
  CSV.foreach(file) do |row|
    Customer.create({
      id:  row[0],
      first_name: row[1],
      last_name: row[2],
      created_at: row[3],
      updated_at: row[4]
    })
  end

  file = "./data/merchants.csv"
  CSV.foreach(file) do |row|
    Merchant.create({
      id:  row[0],
      name: row[1],
      created_at: row[2],
      updated_at: row[3]
    })
  end

  file = "./data/items.csv"
  CSV.foreach(file) do |row|
    Item.create({
      id:          row[0],
      name:        row[1],
      description: row[2],
      unit_price:  row[3].to_f / 100,  #might need to fix migrations? currency methods?
      merchant_id: row[4],
      created_at:  row[5],
      updated_at:  row[6]
      })
  end

  file = "./data/invoices.csv"
  CSV.foreach(file) do |row|
    Invoice.create({
      id:          row[0],
      customer_id: row[1],
      merchant_id: row[2],
      status:      row[3],
      created_at:  row[4],
      updated_at:  row[5]
      })
  end

  file = "./data/invoice_items.csv"
  CSV.foreach(file) do |row|
    InvoiceItem.create({
      id:          row[0],
      item_id:    row[1],
      invoice_id: row[2],
      quantity:   row[3],
      unit_price: row[4].to_f / 100,
      created_at: row[5],
      updated_at: row[6]
      })
  end

  file = "./data/transactions.csv"
  CSV.foreach(file) do |row|
    Transaction.create({
       id:                          row[0],
       invoice_id:                  row[1],
       credit_card_number:          row[2],
       credit_card_expiration_date: row[3],
       result:                      row[4],
       created_at:                  row[5],
       updated_at:                  row[6]
      })
  end
   puts "Seed from CSV Complete."
end

# require 'csv'
#
# csv_text = File.read('...')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   Moulding.create!(row.to_hash)
# end

# require 'csv'
#
# CSV.foreach(filename, :headers => true) do |row|
#   Moulding.create!(row.to_hash)
# end
#
# Clear your Development database to prevent data duplication
# Seed your Development database with the CSV data
# Be invokable through Rake, i.e. you should be able to run bundle exec rake <your_rake_task_name> from the command line
# Convert all prices before storing. Prices are in cents, therefore you will need to transform them to dollars. (12345 becomes 123.45)
# Reset the primary key sequence for each table you import so that new records will receive the next valid primary key.

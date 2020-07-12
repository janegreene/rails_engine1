require 'csv'

desc "Import models from csv file"

task :import => [:environment] do
  # models = [Merchant, Items, Invoice, InvoiceItem, Customer, Transaction]

  file = "app/data/customers.csv"
  CSV.foreach(file) do |row|
    Customer.create({
      name:  row[0],
      keyword: row[1],
      email: row[2],
      phone0: row[3],
      phone1: row[4],
      phone2: row[5]
    })
  end
end
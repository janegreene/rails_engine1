require 'csv'

desc "Tear down and Import models from csv files"

task :import => [:environment] do
  models = [Merchant, Items, Invoice, InvoiceItem, Customer, Transaction]
  models.each do |model|
    model.destroy_all
  end

  # file = "app/data/customers.csv"
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

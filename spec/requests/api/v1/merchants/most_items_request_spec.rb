describe 'business intelligence' do
  it 'can get merchants with most items sold' do
    customer_1 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_1.id)
    item_3 = create(:item, merchant_id: merchant_2.id)
    item_4 = create(:item, merchant_id: merchant_2.id)
    item_5 = create(:item, merchant_id: merchant_2.id)
    item_6 = create(:item, merchant_id: merchant_3.id)
    item_7 = create(:item, merchant_id: merchant_3.id)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 3)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_3.id, quantity: 2)
    invoice_item_4 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_4.id, quantity: 3)
    invoice_item_5 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_5.id, quantity: 12)
    invoice_item_6 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_6.id, quantity: 9)
    invoice_item_7 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_7.id, quantity: 3)
    invoice_item_8 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_1.id, quantity: 3)
    invoice_item_9 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_2.id, quantity: 6)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "rejected")
    transaction_5 = create(:transaction, invoice_id: invoice_2.id, result: "rejected")

    get "/api/v1/merchants/most_items?quantity=2"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(2)
    expect(response).to be_successful
    # expect(json[:data][0][:attributes][:name]).to eq("Dicki-Bednar")
    # expect(json[:data][0][:id]).to eq("14")
    #
    # expect(json[:data][1][:attributes][:name]).to eq("Bechtelar, Jones and Stokes")
    # expect(json[:data][1][:id]).to eq("10")


#     data = Merchant.joins(invoices:[:invoice_items, :transactions]).where("tr
# ansactions.result='success'").group("merchants.name").select("merchants.name, sum(invoice_
# items.quantity*invoice_items.unit_price) as revenue").order("revenue desc").limit(5)
  end
end

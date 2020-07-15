describe 'business intelligence' do
  it 'can get merchants with most revenue' do
    customer_1 = create(:customer)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_1.id)
    item_3 = create(:item, merchant_id: merchant_2.id)
    item_4 = create(:item, merchant_id: merchant_2.id)
    item_5 = create(:item, merchant_id: merchant_2.id)
    item_6 = create(:item, merchant_id: merchant_3.id)
    item_7 = create(:item, merchant_id: merchant_3.id)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_3.id)
    invoice_item_4 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_4.id)
    invoice_item_5 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_5.id)
    invoice_item_6 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_6.id)
    invoice_item_7 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_7.id)
    invoice_item_8 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_1.id)
    invoice_item_9 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_2.id)
    # get "/api/v1/merchants/most_revenue?quantity=7"
    # json = JSON.parse(response.body, symbolize_names: true)
    #
    # expect(json[:data].length).to eq(7)
    #
    # expect(json[:data][0][:attributes][:name]).to eq("Dicki-Bednar")
    # expect(json[:data][0][:id]).to eq("14")
    #
    # expect(json[:data][3][:attributes][:name]).to eq("Bechtelar, Jones and Stokes")
    # expect(json[:data][3][:id]).to eq("10")
    #
    # expect(json[:data][6][:attributes][:name]).to eq("Rath, Gleason and Spencer")
    # expect(json[:data][6][:id]).to eq("53")

    
#     data = Merchant.joins(invoices:[:invoice_items, :transactions]).where("tr
# ansactions.result='success'").group("merchants.name").select("merchants.name, sum(invoice_
# items.quantity*invoice_items.unit_price) as revenue").order("revenue desc").limit(5)
  end
end

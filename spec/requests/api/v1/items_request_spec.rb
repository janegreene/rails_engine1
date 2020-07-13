require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items['data'].count).to eq(3)
    expect(items).to be_instance_of(Hash)
    expect(items['data']).to be_instance_of(Array)
  end
  it "can get one item by its id" do
   id = create(:item).id

   get "/api/v1/items/#{id}"

   item = JSON.parse(response.body)

   expect(response).to be_successful
   expect(item).to be_instance_of(Hash)
   expect(item['data']["id"]).to eq(id.to_s)
 end
 it "can create a new item" do
    merchant = create(:merchant)
    item_params = { name: "Banana", description: "Yellow tree part.", unit_price: 4.00, merchant_id: "#{merchant.id}" }

    post "/api/v1/items", params: {item: item_params}
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq("Yellow tree part.")
    expect(item.unit_price).to eq(4.00)
    expect(item.merchant_id).to eq(merchant.id)
 end
end

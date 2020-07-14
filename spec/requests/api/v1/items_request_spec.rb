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

  it 'can create and delete an item' do
    merchant = create(:merchant, id: 43)

    name = "Shiny Itemy Item"
    description = "It does a lot of things real good"
    unit_price = 5011.96
    merchant_id = 43

    body = {
      name: name,
      description: description,
      unit_price: unit_price,
      merchant_id: merchant_id
    }
    post '/api/v1/items', params: body

    json = JSON.parse(response.body, symbolize_names: true)
    new_item = json[:data]
    expect(new_item[:attributes][:name]).to eq(name)
    expect(new_item[:attributes][:description]).to eq(description)
    expect(new_item[:attributes][:unit_price]).to eq(unit_price)
    expect(new_item[:attributes][:merchant_id]).to eq(merchant_id)

    # Delete a item
    delete "/api/v1/items/#{new_item[:id]}"
    json = JSON.parse(response.body, symbolize_names: true)

    deleted_item = json[:data]
    expect(deleted_item[:attributes][:name]).to eq(name)
    expect(deleted_item[:attributes][:description]).to eq(description)
    expect(deleted_item[:attributes][:unit_price]).to eq(unit_price)
    expect(deleted_item[:attributes][:merchant_id]).to eq(merchant_id)
  end

  it 'can update an item' do
    merchant = create(:merchant, id: 43)
    item = create(:item, merchant: merchant)

    name = "Shiny Itemy Item"
    description = "It does a lot of things real good"
    unit_price = 5011
    merchant_id = 43

    body = {
      name: name,
      description: description,
      unit_price: unit_price,
      merchant_id: merchant_id
    }

    patch "/api/v1/items/#{item[:id]}", params: body

    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data]
    expect(item[:attributes][:name]).to eq(name)
    expect(item[:attributes][:description]).to eq(description)
    expect(item[:attributes][:unit_price]).to eq(unit_price)
    expect(item[:attributes][:merchant_id]).to eq(merchant_id)
  end
end

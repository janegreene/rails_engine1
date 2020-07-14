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
 # it "can create a new item" do
 #    merchant = create(:merchant)
 #    item_params = { name: "Banana", description: "Yellow tree part.", unit_price: 4.00, merchant_id: "#{merchant.id}" }
 #
 #    post "/api/v1/items", params: {item: item_params}
 #    item = Item.last
 #
 #    expect(response).to be_successful
 #    expect(item.name).to eq(item_params[:name])
 #    expect(item.description).to eq("Yellow tree part.")
 #    expect(item.unit_price).to eq(4.00)
 #    expect(item.merchant_id).to eq(merchant.id)
 # end
 # it "can delete an item" do
 #    item = create(:item)
 #
 #    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)
 #
 #    expect(response).to be_successful
 # end

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

        # Create a item
        # response = conn('/api/v1/items').post do |request|
        #   request.body = body
        # end

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
    end
      # it 'can update an item' do
      #   name = "Shiny Itemy Item"
      #   description = "It does a lot of things real good"
      #   unit_price = 5011
      #   merchant_id = 43
      #
      #   body = {
      #     name: name,
      #     description: description,
      #     unit_price: unit_price,
      #     merchant_id: merchant_id
      #   }
      #
      #   response = conn('/api/v1/items/75').patch do |request|
      #     request.body = body
      #   end
      #
      #   json = JSON.parse(response.body, symbolize_names: true)
      #   item = json[:data]
      #   expect(item[:attributes][:name]).to eq(name)
      #   expect(item[:attributes][:description]).to eq(description)
      #   expect(item[:attributes][:unit_price]).to eq(unit_price)
      #   expect(item[:attributes][:merchant_id]).to eq(merchant_id)
      #
      #   original_body = {
      #     name: 'Item Autem Eligendi',
      #     description:'Aliquam dolores dolore voluptas nesciunt non praesentium. Eum nihil repellendus modi. Aut in expedita nesciunt. Ut aliquam dicta omnis voluptas.',
      #     unit_price: '29949',
      #     merchant_id: '3',
      #   }
      #   conn("/api/v1/items/").patch do |request|
      #     request.body = original_body
      #   end
      # end

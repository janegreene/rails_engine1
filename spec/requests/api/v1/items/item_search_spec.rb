require 'rails_helper'

describe "item search endpoints" do
    it 'can find a list of items that contain a fragment, case insensitive' do
      item_1 = create(:item, name: "Tillman")
      item_2 = create(:item, name: "Hilly Hillman")
      item_3 = create(:item, name: "Hello")
      get '/api/v1/items/find_all?name=ILL'

      json = JSON.parse(response.body, symbolize_names: true)
      names = json[:data].map do |items|
        items[:attributes][:name]
      end
      expect(response).to be_successful
      expect(names.sort).to eq(["Hilly Hillman", "Tillman"])
    end

    it 'can find a item that contain a fragment, case insensitive' do
      item_1 = create(:item, name: "Tillman")
      item_2 = create(:item, name: "Hilly Hillman")
      item_3 = create(:item, name: "Hello")

      get '/api/v1/items/find?name=ILL'
      json = JSON.parse(response.body, symbolize_names: true)
      name = json[:data][:attributes][:name].downcase

      expect(response).to be_successful
      expect(json[:data]).to be_a(Hash)
      expect(name).to include('ill')
    end
end

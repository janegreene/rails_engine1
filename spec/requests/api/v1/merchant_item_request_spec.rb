require 'rails_helper'

describe 'Relationships merchant items' do
  it 'can get items for a merchant' do
    merchant = create(:merchant, id:99)
    list = create_list(:item, 10, merchant_id: "#{merchant.id}")

    get '/api/v1/merchants/99/items'
    json = JSON.parse(response.body, symbolize_names: true)
    expected_ids = list.map do |item|
      item.id
    end

    item_ids = json[:data].map do |item|
      item[:id].to_i
    end
    expect(item_ids.sort).to eq(expected_ids)
  end

  # it 'can get merchant for an item' do
  #   response = conn('/api/v1/items/209/merchant').get
  #   json = JSON.parse(response.body, symbolize_names: true)
  #   expected_id = '11'
  #
  #   expect(json[:data][:id]).to eq(expected_id)
  # end
end

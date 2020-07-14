require 'rails_helper'

   describe 'Merchants API' do
      it 'can get a merchant' do
        merchant_1 = create(:merchant, id: 42)

        get '/api/v1/merchants/42'

        expected_attributes = {
          name: "#{merchant_1.name}",
        }

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:id]).to eq('42')

        expected_attributes.each do |attribute, value|
          expect(json[:data][:attributes][attribute]).to eq(value)
        end
      end
      it 'can get all merchants' do
        create_list(:merchant, 3)
        get '/api/v1/merchants'
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data].length).to eq(3)
        json[:data].each do |merchant|
          expect(merchant[:type]).to eq("merchant")
          expect(merchant[:attributes]).to have_key(:name)
        end
      end

      it 'can create and delete a merchant' do
        merchant = create(:merchant)
        name = "#{merchant.name}"

        body = {
          name: name
        }

        # Create a merchant
        post '/api/v1/merchants', params: body
        # response = conn('/api/v1/merchants').post do |request|
        #   request.body = body
        # end

        json = JSON.parse(response.body, symbolize_names: true)

        new_merchant = json[:data]
        expect(new_merchant[:attributes][:name]).to eq(name)

        # Delete a merchant
        delete "/api/v1/merchants/#{new_merchant[:id]}"

        json = JSON.parse(response.body, symbolize_names: true)

        deleted_merchant = json[:data]
        expect(deleted_merchant[:attributes][:name]).to eq(name)
      end

      it 'can update a merchant' do
        merchant = create(:merchant, id: 99)
        name = "#{merchant.name}"

        body = {
          name: "New Name",
        }

        patch '/api/v1/merchants/99', params: body

        json = JSON.parse(response.body, symbolize_names: true)
          item = json[:data]
          expect(item[:attributes][:name]).to eq("New Name")

          original_body = {
            name: 'Fahey-Stiedemann',
          }
          patch "/api/v1/merchants/99", params: original_body
      end
    end

# GET /api/v1/<resource>/find?<attribute>=<value
#refactor if time one search controller sending in type to dry up code
class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = Search.find_by_name(Merchant, params[:name])
    render json: MerchantSerializer.new(merchants).serialized_json
  end
  def show
    merchant = Search.find_by_name(Merchant, params[:name]).first
    render json: MerchantSerializer.new(merchant).serialized_json
  end
end

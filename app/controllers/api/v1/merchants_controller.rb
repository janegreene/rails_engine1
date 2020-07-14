class Api::V1::MerchantsController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def create
    merchant = Merchant.new(merchant_params)
    render json: MerchantSerializer.new(merchant) if merchant.save
  end

  def destroy
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
    Merchant.delete(params[:id])
  end

  def update
    merchant = Merchant.update(params[:id], merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  private

  def merchant_params
    params.permit(:name)
  end
end

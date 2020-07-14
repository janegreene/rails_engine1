class Api::V1::ItemsController < ApplicationController

  def index
    # items = Item.all
    # require "pry"; binding.pry
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  # def create
  #   id = Item.last.id if Item.last
  #   id = 0 if Item.last.nil?
  #   params = item_params.merge(id: id+1)
  #   item = Item.create(params)
  #   render json: ItemSerializer.new(item)
    # item = Item.new(item_params)
    # if item.save
    #   render json: ItemSerializer.new(item)
    # end
    #need error handling
    #still not passing spec harness
    # item = Item.new(item_params)
    # render json: ItemSerializer.new(item) if item.save
  # end

  # def destroy
  #   render json: ItemSerializer.new(Item.destroy(params[:id]))
  # end
  def create
    item = Item.new(item_params)
    render json: ItemSerializer.new(item) if item.save
  end

  def update
    item = Item.update(params[:id], item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    render json: ItemSerializer.new(Item.find(params[:id]))
    Item.delete(params[:id])
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

end

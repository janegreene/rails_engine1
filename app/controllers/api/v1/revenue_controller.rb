class Api::V1::RevenueController < ApplicationController
  def index
    render json: RevenueSerializer.new(Revenue.total_revenue_for_timespan(params))
  end
end

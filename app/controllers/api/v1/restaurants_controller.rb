class Api::V1::RestaurantsController < ApplicationController
  def show
    render json: RestaurantSerializer.new(Restaurant.find(params[:id]))
  end
end

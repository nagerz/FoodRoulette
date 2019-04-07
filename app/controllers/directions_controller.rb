class DirectionsController < ApplicationController
  def show
    if params[:user_address]
      service.directions(params[:user_address], params[:restaurant_address])
    elsif params[:user_lat_long]
      service.directions(params[:user_lat_long], params[:restaurant_address])
    end
  end

  private

  def service
    GoogleMapsService.new
  end
end

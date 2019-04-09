class DirectionsController < ApplicationController
  def show
    if params[:user_lat_long]
      save_restaurant_visit(params[:user_id], params[:restaurant_id], params[:user_lat_long])
      directions = create_directions_url(params[:user_lat_long], params[:restaurant_address])
      redirect_to directions
    elsif params[:user_address]
      save_restaurant_visit(params[:user_id], params[:restaurant_id], params[:user_address])
      directions = create_directions_url(params[:user_address], params[:restaurant_address])
      redirect_to directions
    end
  end

  private

  def save_restaurant_visit(user_id, restaurant_id, location)
    user = User.find(user_id)
    restaurant = Restaurant.find(restaurant_id)
    if location.include?('|')
      latitude = CGI::escape(origin.split('|')[0])
      longitude = CGI::escape(origin.split('|')[1])
    else
      response = service.geocode(location)
      latitude = response[:results][0][:geometry][:location][:lat]
      longitude = response[:results][0][:geometry][:location][:lng]
    end
    Visit.create(user: user,
                 restaurant: restaurant,
                 latitude: latitude,
                 longitude: longitude)
  end

  def create_directions_url(origin = '', destination)
    if origin.include?('|')
      latitude = CGI::escape(origin.split('|')[0])
      longitude = CGI::escape(origin.split('|')[1])
      destination = CGI::escape(destination)
      base_url = 'https://www.google.com/maps/dir/?api=1'
      base_url + "&origin=#{latitude}%C2%B0+N%2C#{longitude}%C2%B0+W&destination=#{destination}"
    else
      origin = CGI::escape(origin)
      destination = CGI::escape(destination)
      base_url = 'https://www.google.com/maps/dir/?api=1'
      base_url + "&origin=#{origin}&destination=#{destination}"
    end
  end

  def service
    GoogleMapsService.new
  end
end

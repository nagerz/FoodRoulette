class RouletteController < ApplicationController
  before_action :check_login

  def show
    if cookies['manual_location'] && cookies['manual_location'] != ''
      render locals: {
        restaurant: RestaurantFacade.new.recommendation(cookies['manual_location'])
      }
    elsif cookies['lat_long']
      render locals: {
        restaurant: RestaurantFacade.new.recommendation(cookies['lat_long'])
      }
    else
      redirect_to root_path
      flash[:alert] = "Please set a search location"
    end
  end

  def index
    if cookies['manual_location'] && cookies['manual_location'] != ''
      render locals: {
        restaurants: RestaurantFacade.new.group_recommendations(cookies['manual_location'])
      }
    elsif cookies['lat_long']
      render locals: {
        restaurants: RestaurantFacade.new.group_recommendations(cookies['lat_long'])
      }
    else
      redirect_to root_path
      flash[:alert] = "Please set a search location"
    end
  end
end

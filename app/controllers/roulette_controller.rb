class RouletteController < ApplicationController
  def show
    if cookies['manual_location']
      render locals: {
        restaurant: RestaurantFacade.new.recommendation(cookies['manual_location'])
      }
    elsif cookies['lat_long']
      render locals: {
        restaurant: RestaurantFacade.new.recommendation(cookies['lat_long'])
      }
    end
  end

  def index
    if cookies['manual_location']
      render locals: {
        restaurants: RestaurantFacade.new.group_recommendations(cookies['manual_location'])
      }
    elsif cookies['lat_long']
      render locals: {
        restaurants: RestaurantFacade.new.group_recommendations(cookies['lat_long'])
      }
    end
  end
end

class RouletteController < ApplicationController
  def show
    render locals: {
      restaurant: RestaurantFacade.new.recommendation(cookies['lat_long'])
    }
  end

  def index
    render locals: {
      restaurants: RestaurantFacade.new.group_recommendations(cookies['lat_long'])
    }
  end
end

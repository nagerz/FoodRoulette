class RouletteController < ApplicationController
  def show
    render locals: {
      restaurant: RestaurantFacade.new.recommendation
    }
  end

  def index
    render locals: {
      restaurants: RestaurantFacade.new.group_recommendations
    }
  end
end

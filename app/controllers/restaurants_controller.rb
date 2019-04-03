class RestaurantsController < ApplicationController
  def show
    render locals: {
      restaurant: RestaurantFacade.new.recommendation
    }
  end
end

class RecommendationsController < ApplicationController
  def show
    render locals: {
      restaurant: YelpFacade.new.recommendation
    }
  end
end

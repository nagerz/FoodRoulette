class RecommendationsController < ApplicationController
  def show
    render locals: {
      yelp_facade: YelpFacade.new
    }
  end
end

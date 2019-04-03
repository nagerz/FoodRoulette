class RouletteController < ApplicationController
  def show
    params[:location] = "Denver, CO"
    render locals: {
      facade: RouletteFacade.new(params[:location])
    }
  end
end

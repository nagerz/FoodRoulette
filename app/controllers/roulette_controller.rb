class RouletteController < ApplicationController
  def show
    params[:location] = ""
    render locals: {
      facade: RouletteFacade.new(params[:location])
    }
  end
end

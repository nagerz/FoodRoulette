class VotesController < ApplicationController

  def show
    @votes = Vote.all
  end

end

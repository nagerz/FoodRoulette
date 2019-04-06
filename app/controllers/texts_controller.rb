class TextsController < ApplicationController

  def create
    @sender = text_params[:sender]
    @phone_numbers = text_params[:phone_numbers]
    @restaurant_1 = text_params[:restaurant_1]
    @restaurant_2 = text_params[:restaurant_2]
    @restaurant_3 = text_params[:restaurant_3]

    respond_to do |format|
      message = "Your friend #{@sender} has requested your vote for where to eat. To vote for #{@restaurant_1}, reply '1' to this message. To vote for #{@restaurant_2}, reply '2' to this message. To vote for #{@restaurant_3}, reply '3', to this message."
      TwilioTextMessenger.new(message).call
    end 

  end

  private

  def text_params
    params.permit(:sender, :phone_numbers, :restaurant_1, :restaurant_2, :restaurant_3, :event)
  end

end

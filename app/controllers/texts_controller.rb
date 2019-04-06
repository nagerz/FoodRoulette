class TextsController < ApplicationController
  def create
    @sender = text_params[:sender]
    @phone_numbers = text_params[:phone_numbers]
    @event = text_params[:event]
    @date_time   = text_params[:date_time]
    @restaurant_1 = text_params[:restaurant_1]
    @restaurant_2 = text_params[:restaurant_2]
    @restaurant_3 = text_params[:restaurant_3]

    TextMessage.send_vote_text(@sender, @restaurant_1, @restaurant_2, @restaurant_3, @event, @date_time)
  end

  private

  def text_params
    params.permit(:sender, :phone_numbers, :restaurant_1, :restaurant_2, :restaurant_3, :event, :date_time)
  end
end

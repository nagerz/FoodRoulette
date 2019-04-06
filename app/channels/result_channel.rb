class ResultChannel < ApplicationCable::Channel

  def subscribed
    stream_from "chat_#{params[:room]}"
    stream_for current_user
  end

end

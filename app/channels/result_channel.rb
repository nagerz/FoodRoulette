class ResultChannel < ApplicationCable::Channel

  def subscribed
    stream_from "results"
    #tells the back-end that this connections should receive
    #all messages on the chat_room channel
    # stream_for current_user
  end

  def result(data)
    survey = Survey.find_by(data[:id])
    survey.result
  end

end

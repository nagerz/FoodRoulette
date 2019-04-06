class TextMessage

  def self.send_vote_text(sender, restaurant_1, restaurant_2, restaurant_3, event, date_time)
    respond_to do |format|
      message = "Your friend #{sender} has requested your vote for where to eat. To vote for #{restaurant_1}, reply '1' to this message. To vote for #{restaurant_2}, reply '2' to this message. To vote for #{restaurant_3}, reply '3', to this message. (#{event} #{date_time})"

      TwilioTextMessenger.new(message).call
    end
  end


end

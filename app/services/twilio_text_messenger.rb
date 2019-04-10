class TwilioTextMessenger
  attr_reader :message, :phone_numbers

  def send_survey(data)
    @sender = data[:sender]
    @phone_numbers = data[:phone_numbers]
    @event = data[:event]
    @date_time = data[:date_time]
    @restaurant_1 = data[:restaurant_1]
    @restaurant_2 = data[:restaurant_2]
    @restaurant_3 = data[:restaurant_3]

    message = "Your friend #{@sender} has requested your vote for where to eat. To vote for #{@restaurant_1}, reply '1' to this message. To vote for #{@restaurant_2}, reply '2' to this message. To vote for #{@restaurant_3}, reply '3', to this message. (#{@event} #{@date_time})"

    @phone_numbers.each do |phone_number|
      client = Twilio::REST::Client.new
      response = client.messages.create({
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: phone_number,
        body: message,
      })
    end
  end

  def send_vote_receipt(survey_id)
    message = "Thanks for voting! If you'd like to see which restaurant is winning, go to #{}"

    client = Twilio::REST::Client.new
    response = client.messages.create({
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: phone_number,
      body: message,
    })
  end

  def send_survey_result(survey_id)
    @survey ||= Survey.find(survey_id)
    phone_numbers = []
    @survey.phone_numbers.each do |phone_number|
      phone_numbers << phone_number.digits
    end
    event = @survey.event
    winner = @survey.winner.name
    message = "The survey for #{event} is now closed! #{winner} is the winner!"

    client = Twilio::REST::Client.new
    response = client.messages.create({
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: phone_numbers,
      body: message,
    })
  end

  def send_invalid_vote_response(phone_number)
    message = "Invalid response. Answer should be '1', '2', or '3'. Please try again."

    client = Twilio::REST::Client.new
    response = client.messages.create({
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: phone_number,
      body: message,
    })
  end

end

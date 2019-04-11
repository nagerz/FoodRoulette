# frozen_string_literal: true

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
      response = client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: phone_number,
        body: message
      )
    end
  end

  def send_valid_vote_response(phone_number, survey, url)
    message = "Thanks for voting! If you'd like to see which restaurant is winning, visit #{url}."

    client = Twilio::REST::Client.new
    response = client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: phone_number,
      body: message
    )
  end

  def send_invalid_vote_response(phone_number)
    message = "Your reply needs to be a '1', '2', or '3'. Please try again!"

    client = Twilio::REST::Client.new
    response = client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: phone_number,
      body: message
    )
  end

  def send_survey_result(survey_id, url)
    @survey ||= Survey.find(survey_id)
    phone_numbers = []
    @survey.phone_numbers.each do |phone_number|
      phone_numbers << phone_number.digits
    end
    event = @survey.event
    winner = @survey.winner.name
    message = "Your recent survey has ended! #{winner} got the most votes. See the results here: #{url}."

    client = Twilio::REST::Client.new
    response = client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: phone_numbers,
      body: message
    )
  end

end

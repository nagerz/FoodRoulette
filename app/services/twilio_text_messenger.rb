class TwilioTextMessenger
  attr_reader :message, :phone_numbers

  def initialize(data)
    @sender = data[:sender]
    @phone_numbers = data[:phone_numbers]
    @event = data[:event]
    @date_time = data[:date_time]
    @restaurant_1 = data[:restaurant_1]
    @restaurant_2 = data[:restaurant_2]
    @restaurant_3 = data[:restaurant_3]
  end

  def send_survey
    message = "Your friend #{@sender} has requested your vote for where to eat. To vote for #{@restaurant_1}, reply '1' to this message. To vote for #{@restaurant_2}, reply '2' to this message. To vote for #{@restaurant_3}, reply '3', to this message. (#{@event} #{@date_time})"

    client = Twilio::REST::Client.new
    client.messages.create({
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: @phone_numbers,
      body: message
    })
  end

  # def call
  #   client = Twilio::REST::Client.new
  #   client.messages.create({
  #     from: ENV['TWILIO_PHONE_NUMBER'],
  #     to: phone_numbers,
  #     body: message
  #   })
  # end
end

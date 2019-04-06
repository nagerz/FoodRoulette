class TwilioTextMessenger
  attr_reader :message, :phone_numbers

  def initialize(message, phone_numbers)
    @message = message
    @phone_numbers = phone_numbers
  end

  def call
    client = Twilio::REST::Client.new
    client.messages.create({
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: phone_numbers,
      body: message
    })
  end
end

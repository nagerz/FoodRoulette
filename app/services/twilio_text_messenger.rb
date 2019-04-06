class TwilioTextMessenger
  attr_reader :message, :phone_numbers

  def initialize(data)
    @sender = data[:sender]
    @phone_numbers = data[:phone_numbers].split(/\s*,\s*/)
    @event = data[:event]
    @date_time = data[:date_time]
    @restaurant_1 = data[:restaurant_1]
    @restaurant_2 = data[:restaurant_2]
    @restaurant_3 = data[:restaurant_3]
  end

  def send_survey
    message = "Your friend #{@sender} has requested your vote for where to eat. To vote for #{@restaurant_1}, reply '1' to this message. To vote for #{@restaurant_2}, reply '2' to this message. To vote for #{@restaurant_3}, reply '3', to this message. (#{@event} #{@date_time})"

    status = []

    @phone_numbers.each do |phone_number|
      client = Twilio::REST::Client.new
      response = client.messages.create({
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: phone_number,
        body: message,
        #status_callback: 'http://localhost:3000/twilio/status'
        # status_callback: 'https://postb.in/lPR0Of7g'
      })
      status << response.status
    end
  end

  def status
    binding.pry
   # the status can be found in params['MessageStatus']

   # send back an empty response

   render_twiml Twilio::TwiML::Response.new

  end
end

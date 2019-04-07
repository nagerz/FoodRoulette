class ResponsesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    message_body = params["Body"]
    from_number = params["From"]

    TwilioTextMessenger.new.send_vote_receipt
  end
end


    # boot_twilio

    # sms = @client.messages.create(
    #   from: ENV['TWILIO_PHONE_NUMBER'],
    #   to: from_number,
    #   body: "Hello there, thanks for texting me. Your number is #{from_number}."
    # )

  # end

  # private
  #
  # def boot_twilio
  #   account_sid = ENV['TWILIO_ACCOUNT_SID']
  #   auth_token = ENV['TWILIO_AUTH_TOKEN']
  #   @client = Twilio::REST::Client.new account_sid, auth_token
  # end

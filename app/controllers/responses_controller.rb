class ResponsesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    message_body = params["Body"]
    from_number = params["From"]
    sms_id = params["SmsSid"]

    TwilioTextMessenger.new.send_vote_receipt
  end

end

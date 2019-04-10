class InvalidResponseTextJob < ApplicationJob
  queue_as :default

  def perform(phone_number)
    TwilioTextMessenger.new.send_invalid_vote_response(phone_number)
  end
end

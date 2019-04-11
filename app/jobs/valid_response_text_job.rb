# frozen_string_literal: true

class ValidResponseTextJob < ApplicationJob
  queue_as :default

  def perform(phone_number, survey, url)
    TwilioTextMessenger.new.send_valid_vote_response(phone_number, survey, url)
  end
end

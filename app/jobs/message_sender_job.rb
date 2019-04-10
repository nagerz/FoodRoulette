class MessageSenderJob < ApplicationJob
  queue_as :default

  def perform(data)
    TwilioTextMessenger.new.send_survey(data)
  end
end

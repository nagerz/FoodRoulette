class ResponsesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    message_body = params["Body"]
    from_number = params["From"]

    Vote.create_vote(from_number, message_body)
  end

end

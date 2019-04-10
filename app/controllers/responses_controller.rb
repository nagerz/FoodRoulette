# frozen_string_literal: true

class ResponsesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    message_body = params['Body']
    from_number = params['From']
    phone_number = PhoneNumber.where(digits: from_number).last
    survey = phone_number.survey

    Vote.create_vote(from_number, message_body, survey)
  end
end

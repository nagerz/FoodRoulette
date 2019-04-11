# frozen_string_literal: true

class Api::V1::SurveysController < ApplicationController
  def show
    render json: SurveySerializer.new(Survey.find(params[:id]))
  end
end

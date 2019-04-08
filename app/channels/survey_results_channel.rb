class SurveyResultsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "survey_results_channel"
    #we wanna interpolate the survey id
  end

  def unsubscribed
    stop_all_streams
  end

  def vote(data)
    sr = SurveyRestaurant.last
    Vote.create!(value: data['vote_value'].to_i, survey_restaurant: sr)
  end
end

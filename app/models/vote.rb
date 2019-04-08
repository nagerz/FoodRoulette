class Vote < ApplicationRecord
  after_create_commit {VoteBroadcastJob.perform_later self}
  belongs_to :survey_restaurant

  def self.total_votes(vote)
    self.joins(survey_restaurant: :survey).where(survey_id = vote.survey_restaurant.survey.id)
  end

  def self.survey_restaurant_votes(vote)
  end
end

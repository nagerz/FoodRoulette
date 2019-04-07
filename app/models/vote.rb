class Vote < ApplicationRecord
  after_create_commit {VoteBroadcastJob.perform_later self}
  belongs_to :survey_restaurant
end

class Survey < ApplicationRecord
  attr_accessor :sender, :event, :date_time, :restaurant_1, :restaurant_2, :restaurant_3

  belongs_to :user
  has_many :survey_restaurants
  has_many :restaurants, through: :survey_restaurants

  def bark
    ActionCable.server.broadcast "results", {id: id}
    #actioncable.server.broadcast is the method used
    #to send a message to all clients listening on the
    #results channel. We also send a hash including the id
    #of the survey
  end
end

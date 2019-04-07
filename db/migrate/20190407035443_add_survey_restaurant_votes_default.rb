class AddSurveyRestaurantVotesDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :survey_restaurants, :votes, :integer, default: 0
  end
end

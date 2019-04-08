class AddUpdates < ActiveRecord::Migration[5.2]
  def change
    remove_column :survey_restaurants, :votes
    remove_column :surveys, :votes
    add_reference :votes, :survey_restaurant, index: true
  end
end

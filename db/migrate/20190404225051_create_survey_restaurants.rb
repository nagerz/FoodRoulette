class CreateSurveyRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_restaurants do |t|
      t.references :survey, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.integer :votes
      t.integer :rank

      t.timestamps
    end
  end
end

class AddDefaultToSurveyVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :votes, :integer, :default => 0
  end
end

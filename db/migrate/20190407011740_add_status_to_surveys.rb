class AddStatusToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :status, :integer, default: 0
  end
end

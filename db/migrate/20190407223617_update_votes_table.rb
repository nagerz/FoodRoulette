class UpdateVotesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :voter
    add_reference :votes, :phone_number, index: true
  end
end

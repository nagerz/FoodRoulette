class AddVoteToPhoneumber < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :phone_number_id
    add_reference :phone_numbers, :vote, index: true
  end
end

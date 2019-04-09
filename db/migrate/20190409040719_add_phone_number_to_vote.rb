class AddPhoneNumberToVote < ActiveRecord::Migration[5.2]
  def change
    remove_column :phone_numbers, :vote_id
    add_reference :votes, :phone_number, index: true
  end
end

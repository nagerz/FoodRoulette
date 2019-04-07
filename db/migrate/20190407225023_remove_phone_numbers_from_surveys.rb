class RemovePhoneNumbersFromSurveys < ActiveRecord::Migration[5.2]
  def change
    remove_column :surveys, :phone_numbers
    remove_column :votes, :value
  end
end

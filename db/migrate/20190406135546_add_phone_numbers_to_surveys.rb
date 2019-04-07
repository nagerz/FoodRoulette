class AddPhoneNumbersToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :phone_numbers, :text
  end
end

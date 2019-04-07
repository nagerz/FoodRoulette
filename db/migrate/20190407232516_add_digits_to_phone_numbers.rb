class AddDigitsToPhoneNumbers < ActiveRecord::Migration[5.2]
  def change
    add_column :phone_numbers, :digits, :string
  end
end

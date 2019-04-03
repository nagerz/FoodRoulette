class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :google_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :token

      t.timestamps
    end
  end
end

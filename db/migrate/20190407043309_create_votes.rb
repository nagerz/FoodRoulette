class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :survey_restaurant, foreign_key: true
      t.integer :value
      t.bigint :voter

      t.timestamps
    end
  end
end

class AddToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :refresh_token, :text
    add_column :users, :thumbnail, :text
  end
end

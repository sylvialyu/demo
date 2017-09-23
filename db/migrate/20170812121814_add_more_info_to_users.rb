class AddMoreInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :gender, :string
    add_column :users, :avatar, :string

    add_index :users, :username, unique: true
  end
end

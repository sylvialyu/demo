class DropInstalls < ActiveRecord::Migration[5.0]
  def change
    drop_table :identifies
    drop_table :identities
  end
end

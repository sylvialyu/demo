class AddLevelIdToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :level_id, :integer
  end
end

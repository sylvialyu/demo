class AddFriendlyIdToLevels < ActiveRecord::Migration[5.0]
  
  def change
    add_column :levels, :friendly_id, :string
    add_index :levels, :friendly_id, :unique => true

    Level.find_each do |l|
      l.update(:friendly_id => SecureRandom.uuid)
    end
  end

end

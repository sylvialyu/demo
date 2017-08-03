class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.string :title
      t.string :subtitle
      t.text :goal
      t.text :content
      t.text :task
      t.timestamps
    end
  end
end

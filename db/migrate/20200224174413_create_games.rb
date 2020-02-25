class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :full_name
      t.string :acronym

      t.timestamps
    end
  end
end

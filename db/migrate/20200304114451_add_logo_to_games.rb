class AddLogoToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :logo, :string
  end
end

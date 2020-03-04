class AddUrlToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :url, :string
  end
end

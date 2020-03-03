class RenameLocationColumnCompetitionToApiId < ActiveRecord::Migration[5.2]
  def change
    rename_column :competitions, :location, :api_id
  end
end

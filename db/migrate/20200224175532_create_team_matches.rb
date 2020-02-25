class CreateTeamMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :team_matches do |t|
      t.references :match, foreign_key: true
      t.references :team, foreign_key: true
      t.boolean :is_winner

      t.timestamps
    end
  end
end

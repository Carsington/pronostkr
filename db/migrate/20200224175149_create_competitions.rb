class CreateCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :competitions do |t|
      t.string :name
      t.text :description
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end

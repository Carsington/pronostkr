class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.datetime :scheduled_time
      t.references :competition, foreign_key: true

      t.timestamps
    end
  end
end

class AddLiveUrlToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :live_url, :string
  end
end

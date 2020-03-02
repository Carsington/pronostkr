class Player < ApplicationRecord
  belongs_to :team

  validates :scene_name, :full_name, :team, presence: true
  # validates :full_name, uniqueness: { scope: :scene_name }
end

class Match < ApplicationRecord
  belongs_to :competition
  has_many :team_matches, dependent: :destroy
  has_many :teams, through: :team_matches
  has_many :forecasts, dependent: :destroy

  validates :scheduled_time, :competition, presence: true
end

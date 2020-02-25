class Match < ApplicationRecord
  belongs_to :competition
  has_many :team_matches, dependent: :destroy
  has_many :forecasts, dependent: :destroy
end

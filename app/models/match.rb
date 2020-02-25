class Match < ApplicationRecord
  belongs_to :competition
  has_many :team_matches
  has_many :forecasts
end

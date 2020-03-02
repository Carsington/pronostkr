class Team < ApplicationRecord
  has_many :players
  has_many :team_matches, dependent: :destroy
  has_many :matches, through: :team_matches
  has_many :competitions, through: :matches
  has_many :forecasts

  validates :name, presence: true, uniqueness: true
end

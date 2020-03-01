class TeamMatch < ApplicationRecord
  belongs_to :match
  belongs_to :team

  validates :match, :team, presence: true
  validates :match, uniqueness: { scope: :team, message: "can be played once per team" }
end

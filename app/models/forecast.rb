class Forecast < ApplicationRecord
  belongs_to :user
  belongs_to :match
  belongs_to :team
  has_one :competition, through: :match

  validates :user, :match, :team, presence: true
  # validates that the team chosen belongs to the match
  validates :match, uniqueness: { scope: :user, message: "can be forecast once per user" }

end

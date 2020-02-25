class League < ApplicationRecord
  belongs_to :competition
  has_many :user_leagues
end

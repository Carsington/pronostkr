class League < ApplicationRecord
  belongs_to :competition
  has_many :user_leagues
  has_many :users, through: :user_leagues

  validates :slug, :name, :competition, presence: true
  validates :slug, uniqueness: true
end

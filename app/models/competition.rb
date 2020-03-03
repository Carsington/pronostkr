class Competition < ApplicationRecord
  after_create :build_general_league

  belongs_to :game
  has_many :matches
  has_many :leagues
  has_many :forecasts, through: :matches

  validates :name, :start_date, :game, presence: true
  validates :name, uniqueness: true

  include PgSearch::Model

  pg_search_scope :global_search,
    against: [ :name ],
    associated_against: {
      game: [ :full_name, :acronym ]
    },
    using: {
      tsearch: { prefix: true }
    }

  def general_league
    League.find_by(slug: self.name)
  end

  private

  def build_general_league
    League.create(name: "Général #{self.name}", slug: "#{self.name}", competition: self )
  end

end

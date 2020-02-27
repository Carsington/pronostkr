class Competition < ApplicationRecord
  belongs_to :game
  has_many :matches
  has_many :leagues

  include PgSearch::Model

  pg_search_scope :search,
    against: [ :game, :description ],
    using: {
      tsearch: { prefix: true }
    }

end

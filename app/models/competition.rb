class Competition < ApplicationRecord
  belongs_to :game
  has_many :matches
  has_many :leagues

  include PgSearch::Model

  pg_search_scope :global_search,
    against: [ :name ],
    associated_against: {
      game: [ :full_name, :acronym ]
    },
    using: {
      tsearch: { prefix: true }
    }

end

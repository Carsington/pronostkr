class Competition < ApplicationRecord
  after_create :build_general_league

  belongs_to :game
  has_many :matches
  has_many :leagues
  has_many :forecasts, through: :matches

  validates :name, :start_date, :game, presence: true
  validates :name, uniqueness: true

  scope :upcoming,         -> { where("start_date > ?", Time.now) }
  scope :live_or_finished, -> { where("start_date < ?", Time.now) }
  scope :live,             -> { live_or_finished.where("end_date > ? OR end_date IS NULL", Time.now) }
  scope :finished,         -> { live_or_finished.where("end_date < ?", Time.now) }

  def upcoming?
    Competition.upcoming.include? self
  end

  def live?
    Competition.live.include? self
  end

  def finished?
    Competition.finished.include? self
  end



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
    League.find_by(slug: self.name.downcase)
  end

  private

  def build_general_league
    League.create(name: "Général #{self.name}", slug: "#{self.name}".downcase, competition: self )
  end

end

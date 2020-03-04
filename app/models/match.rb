class Match < ApplicationRecord
  belongs_to :competition
  has_many :team_matches, dependent: :destroy
  has_many :teams, through: :team_matches
  has_many :forecasts, dependent: :destroy

  validates :scheduled_time, :competition, presence: true

  scope :upcoming,         -> { where("scheduled_time > ?", Time.now) }
  scope :live_or_finished, -> { where("scheduled_time < ?", Time.now) }
  scope :live,             -> { live_or_finished.joins(:team_matches).where("team_matches.is_winner IS NULL").distinct }
  scope :finished,         -> { live_or_finished.joins(:team_matches).where("team_matches.is_winner IS NOT NULL").distinct }

  def upcoming?
    Match.upcoming.include? self
  end

  def live?
    Match.live.include? self
  end

  def finished?
    Match.finished.include? self
  end
end

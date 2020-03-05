class Match < ApplicationRecord
  belongs_to :competition
  has_many :team_matches, dependent: :destroy
  has_many :teams, through: :team_matches
  has_many :forecasts, dependent: :destroy

  validates :scheduled_time, :competition, presence: true

  scope :upcoming,         -> { where("scheduled_time > ?", Time.now).order(:scheduled_time) }
  scope :live_or_finished, -> { where("scheduled_time < ?", Time.now) }
  scope :live,             -> { live_or_finished.joins(:team_matches).where("team_matches.is_winner IS NULL").distinct.order(:scheduled_time) }
  scope :finished,         -> { live_or_finished.joins(:team_matches).where("team_matches.is_winner IS NOT NULL").distinct.order(:scheduled_time) }

  def upcoming?
    Match.upcoming.include? self
  end

  def live?
    Match.live.include? self
  end

  def finished?
    Match.finished.include? self
  end

  def countdown
    seconds_to_match = self.scheduled_time - Time.now

    return "J-#{(seconds_to_match / 86400).to_i}" if seconds_to_match / 86400 >= 1
    return "H-#{(seconds_to_match / 3600).to_i}" if seconds_to_match / 3600 >= 1
    return "M-#{(seconds_to_match / 60).to_i}"
  end
end

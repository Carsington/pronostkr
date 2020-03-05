class League < ApplicationRecord
  belongs_to :competition
  has_many :user_leagues
  has_many :users, through: :user_leagues

  validates :slug, :name, :competition, presence: true
  validates :slug, uniqueness: true

  def ranking
    participants = self.users
    finished_matches = self.competition.matches.finished

    participants.each do |participant|
      user_league = UserLeague.find_by(user: participant, league: self)
      user_league.score = 0

      finished_matches.each do |finished_match|
        forecast = Forecast.find_by(match: finished_match, user: participant)
        next if forecast.nil?

        if forecast.team == TeamMatch.find_by(match: finished_match, is_winner: true).team
          user_league.score += 1
          user_league.save
        end
      end
    end

    return UserLeague.where(league: self).order(:score).reverse.map { |user_league| user_league.user }
  end
end

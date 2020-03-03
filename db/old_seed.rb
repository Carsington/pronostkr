require 'faker'

N_USERS = 20
N_COMPETITIONS = 25
N_TEAMS = 150
N_PLAYERS = 800
N_MATCHES = 2000
N_LEAGUES = 4
N_FORCASTS = 200

puts "Destroying old instances..."

User.destroy_all
Player.destroy_all
Team.destroy_all
Match.destroy_all
League.destroy_all
Competition.destroy_all
Game.destroy_all


puts "Creating new instances..."

# toto
User.create!(
    email: "toto@toto.toto",
    username: "toto",
    password: "cocorico"
  )

# USERS
N_USERS.times do
  username = Faker::Internet.unique.username

  User.create!(
    email: Faker::Internet.safe_email(name: username),
    username: username,
    password: "cocorico"
  )
end
puts "Built #{User.count} User instances!"


# GAME
Game.create!(full_name: "Counter-Strike: Global Offensive", acronym: "csgo")
Game.create!(full_name: "League of Legends", acronym: "lol")
puts "Built LOL & CSGO Game instances!"

# COMPETITIONS
N_COMPETITIONS.times do |i|
  Competition.create!(
    name: "Competition #{i*i}",
    description: Faker::Lorem.unique.paragraph(sentence_count: 15),
    api_id: Faker::Address.unique.full_address,
    start_date: Faker::Date.between(from: 180.days.ago, to: 2.days.ago),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 180.days.from_now),
    game: Game.all.sample
  )
end
puts "Built #{Competition.count} Competition instances!"

# TEAMS
N_TEAMS.times do
  Team.create!(
    name: Faker::Team.unique.name,
    nationality: Faker::Address.unique.country
  )
end
puts "Built #{Team.count} Team instances!"

# PLAYERS
N_PLAYERS.times do
  Player.create!(
    scene_name: Faker::Internet.unique.domain_word,
    full_name: Faker::Name.unique.name,
    team: Team.all.sample
  )
end
puts "Built #{Player.count} Player instances!"

# MATCHES
N_MATCHES.times do
  competition = Competition.all.sample

  Match.create!(
    scheduled_time: Faker::Time.between_dates(from: competition.start_date, to: competition.end_date),
    competition: competition
  )
end
puts "Built #{Match.count} Match instances!"

# TEAM_MATCHES
Match.all.each do |match|
  team_a = Team.all.sample
  team_b = Team.all.sample
  team_b = Team.all.sample until team_b != team_a

  outcome = [true, false, nil].sample

  TeamMatch.create!(match: match, team: team_a, is_winner: outcome)
  TeamMatch.create!(match: match, team: team_b, is_winner: outcome.nil? ? nil : !outcome)
end
puts "Built #{TeamMatch.count} TeamMatch instances!"


# LEAGUES
N_LEAGUES.times do |i|
  League.create!(
    slug: Faker::Lorem.unique.characters(number: 6).upcase,
    name: "League #{i*i}",
    competition: Competition.all.sample
  )
end
puts "Built #{League.count} League instances!"

# USER_LEAGUES
League.all.each do |league|
  users = User.all.sample(10)

  users.each do |user|
    UserLeague.create!(
      user: user,
      league: league,
      is_owner: [true, false].sample # TODO: change to only 1 league owner
    )
  end
end
puts "Built #{UserLeague.count} UserLeague instances!"

# FORECASTS
N_FORCASTS.times do
  user = User.all.sample
  match = Match.all.sample
  teams = match.teams

  Forecast.create!(
    user: user,
    match: match,
    team: teams.sample
  )
end
puts "Built #{Forecast.count} Forecast instances!"

puts "Success!"

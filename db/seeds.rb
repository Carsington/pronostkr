require 'faker'

puts "Destroying old instances..."

User.destroy_all
Player.destroy_all
Team.destroy_all
Match.destroy_all
League.destroy_all
Competition.destroy_all
Game.destroy_all


puts "Creating new instances..."

# USERS
10.times do
  username = Faker::Internet.unique.username

  User.create!(
    email: Faker::Internet.safe_email(name: username),
    username: username,
    password: "cocorico"
  )
end


# GAME
Game.create!(full_name: "Counter-Strike: Global Offensive", acronym: "csgo")
Game.create!(full_name: "League of Legends", acronym: "lol")

# COMPETITIONS
5.times do |i|
  Competition.create!(
    name: "Competition #{i*i}",
    description: Faker::Lorem.unique.paragraph(sentence_count: 15),
    location: Faker::Address.unique.full_address,
    start_date: Faker::Date.between(from: 180.days.ago, to: 2.days.ago),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 180.days.from_now),
    game: Game.all.sample
  )
end

# TEAMS
10.times do
  Team.create!(
    name: Faker::Team.unique.name,
    nationality: Faker::Address.unique.country
  )
end

# PLAYERS
50.times do
  Player.create!(
    scene_name: Faker::Internet.unique.domain_word,
    full_name: Faker::Name.unique.name,
    team: Team.all.sample
  )
end

# MATCHES
30.times do
  competition = Competition.all.sample

  Match.create!(
    scheduled_time: Faker::Time.between_dates(from: competition.start_date, to: competition.end_date),
    competition: competition
  )
end

# TEAM_MATCHES
Match.all.each do |match|
  team_a = Team.all.sample
  team_b = Team.all.sample
  team_b = Team.all.sample until team_b != team_a

  outcome = [true, false, nil].sample

  TeamMatch.create!(match: match, team: team_a, is_winner: outcome)
  TeamMatch.create!(match: match, team: team_b, is_winner: outcome.nil? ? nil : !outcome)
end


# LEAGUES
10.times do |i|
  League.create!(
    slug: Faker::Lorem.unique.characters(number: 6).upcase,
    name: "League #{i*i}",
    competition: Competition.all.sample
  )
end

# USER_LEAGUES
League.all.each do |league|
  rand(10).times do
    user = User.all.sample

    UserLeague.create!(
      user: user,
      league: league,
      is_owner: [true, false].sample # TODO: change to only 1 league owner
    )
  end
end

# FORECASTS
100.times do
  user = User.all.sample
  match = Match.all.sample
  teams = TeamMatch.where(match: match).map { |teammatch| teammatch.team }

  Forecast.create!(
    user: user,
    match: match,
    team: teams.sample
  )
end

puts "Success!"

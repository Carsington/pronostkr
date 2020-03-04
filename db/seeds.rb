require "json"
require "rest-client"

puts "Destroying old instances..."

User.destroy_all
Player.destroy_all
Team.destroy_all
Match.destroy_all
League.destroy_all
Competition.destroy_all
Game.destroy_all

# USERS
User.create!(
  email: "pilou@example.com",
  username: "pilou",
  password: "cocorico"
)

# require "faker"
# 10.times do
#   username = Faker::Internet.unique.username
#   User.create!(
#     email: Faker::Internet.safe_email(name: username),
#     username: username,
#     password: "cocorico"
#   )
# end
# puts "Built #{User.count} User instances!"

# GAMES
Game.create!(full_name: "Counter-Strike: Global Offensive", acronym: "cs-go")
Game.create!(full_name: "League of Legends", acronym: "league-of-legends")
# Game.create!(full_name: "Fortnite", acronym: "fortnite")
Game.create!(full_name: "Overwatch", acronym: "ow")
Game.create!(full_name: "Rocket League", acronym: "rl")

acronyms = Game.all.map { |game| game.acronym }
puts "Built #{Game.count} Game instances!"

PANDASCORE_KEY = "difWeljL3CxNE3Nx_z37WUo_OeLyaVqwskBftDOJYVN_z4uiFcI"

10.times do |page_number|
  puts "Building Competition instances for page ##{page_number + 1}..."

  competitions_request = "https://api.pandascore.co/series?token=#{PANDASCORE_KEY}&page=#{page_number + 1}&filter[year]=2020"
  competitions = JSON.parse(RestClient.get competitions_request)

  competitions.each do |competition|
    next unless acronyms.include? competition["videogame"]["slug"]

    Competition.create!(
      name: "#{competition["league"]["name"]}#{' ' + competition["name"] if competition["name"]}",
      description: competition["description"],
      api_id: competition["id"],
      start_date: competition["begin_at"],
      end_date: competition["end_at"],
      game: Game.find_by(acronym: competition["videogame"]["slug"])
    )
  end
end

puts "Built #{Competition.count} Competition instances!"


# MATCHES
Competition.all.each do |competition|

  matches = JSON.parse(RestClient.get "https://api.pandascore.co/series/#{competition[:api_id]}/matches?token=#{PANDASCORE_KEY}&per_page=100")

  matches.each do |match|
    next if match["opponents"].length < 2
    next if match["status"] == "canceled"
    next if match["rescheduled"]

    this_match = Match.create!(
      scheduled_time: match["scheduled_at"],
      competition: competition
    )

    opponents = match["opponents"]

    opponents.each do |opponent|
      team = opponent["opponent"]

      this_team = Team.find_by(api_id: team["id"])

      if this_team.nil?
        this_team = Team.create!(
          name: team["name"],
          nationality: team["location"],
          logo_url: team["image_url"],
          api_id: team["id"].to_s
        )
      end

      TeamMatch.create!(
        match: this_match,
        team: this_team,
        is_winner: match["end_at"] ? this_team[:api_id] == match["winner_id"].to_s : nil
      )
    end
  end

  puts "Built #{Match.count} Match instances!"
end

puts "Seed complete!"

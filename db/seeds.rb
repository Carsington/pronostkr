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

#USERS
pilou = User.create!(
  email: "pilou@example.com",
  username: "pilou",
  password: "cocorico"
)

# GAMES
Game.create!(full_name: "Counter-Strike: Global Offensive", acronym: "cs-go", logo: "https://1000logos.net/wp-content/uploads/2017/12/CSGO-Symbol.jpg")
Game.create!(full_name: "League of Legends", acronym: "league-of-legends", logo: "https://pre.breakflip.com/uploads/Drui/Avril%202018/Images/Lol.png")
Game.create!(full_name: "Overwatch", acronym: "ow", logo: "https://gamepedia.cursecdn.com/overwatch_gamepedia/thumb/b/b2/Overwatch_White.jpg/350px-Overwatch_White.jpg?version=b9ad5966dd0c3946bc449870ecd1ba09")
Game.create!(full_name: "Rocket League", acronym: "rl", logo: "https://www.dafont.com/forum/attach/orig/5/1/517500.png")

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
      game: Game.find_by(acronym: competition["videogame"]["slug"]),
      url: competition["league"]["url"]
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
      competition: competition,
      live_url: match["live_url"]
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

# CUSTOM LEAGUE W/ USERS & FORECASTS

require "faker"
10.times do
  username = Faker::Internet.unique.username
  User.create!(
    email: Faker::Internet.safe_email(name: username),
    username: username,
    password: "cocorico"
  )
end
puts "Built #{User.count} User instances!"

league = League.create!(name: "Ligue du Wagon", slug: "lwagon", competition: Competition.find_by(name: "LCL"))
puts "Built LCL League with #LWAGON slug!"

User.all.each do |user|
  UserLeague.create!(
    user: user,
    league: league,
    is_owner: false
  )

  league.competition.matches.each do |match|
    Forecast.create!(
      user: user,
      match: match,
      team: match.teams.sample
    )
  end
end

puts "Seed complete!"

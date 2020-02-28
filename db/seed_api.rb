require "json"
require "rest-client"


url_lol_compets = "https://api.pandascore.co/lol/tournaments?token=#{panda_token}"
url_lol_teams = "https://api.pandascore.co/lol/teams?token=#{panda_token}"
url_csgo_compets = "https://api.pandascore.co/csgo/tournaments?token=#{panda_token}"
url_csgo_teams = "https://api.pandascore.co/csgo/teams?token=#{panda_token}"

lol_compets = RestClient.get url_lol_compets
compets = JSON.parse(lol_compets)

compets.each do |compet|
  # p compet["id"]
  # p compet["begin_at"]
  # p compet["end_at"]
  # p compet["league_id"]
  # p compet["league"]["slug"]
  # p compet["league"]["image_url"]
  # p compet["league"]["name"]
  compet["matches"].each do |matche|
    # p matche["begin_at"]
    # p matche["live_url"]
    # p matche["name"]
    # p matche["id"]
    # p matche["scheduled_at"]
    # p matche["status"]
    # p matche["tournament_id"]
    # p matche["winner_id"]
    # p matche["slug"]
  end
end

lol_teams = RestClient.get url_lol_teams
teams = JSON.parse(lol_teams)

teams.each do |team|
  # p team["acronym"]
  # p team["id"]
  # p team["image_url"]
  # p team["location"]
  # p team["name"]
  team["players"].each do |player|
    # p player["first_name"]
    # p player["last_name"]
    # p player["name"]
    # p player["role"]
    # p player["slug"]
    # p player["nationality"]
    # p player["id"]
  end
end

csgo_compets = RestClient.get url_csgo_compets
compets = JSON.parse(csgo_compets)

compets.each do |compet|
  # p compet["id"]
  # p compet["begin_at"]
  # p compet["end_at"]
  # p compet["league_id"]
  # p compet["league"]["slug"]
  # p compet["league"]["image_url"]
  # p compet["league"]["name"]
  compet["matches"].each do |matche|
    # p matche["begin_at"]
    # p matche["live_url"]
    # p matche["name"]
    # p matche["id"]
    # p matche["scheduled_at"]
    # p matche["status"]
    # p matche["tournament_id"]
    # p matche["winner_id"]
    # p matche["slug"]
  end
end

csgo_teams = RestClient.get url_csgo_teams
teams = JSON.parse(csgo_teams)

teams.each do |team|
  # p team["acronym"]
  # p team["name"]
  # p team["id"]
  # p team["image_url"]
  # p team["location"]
  team["players"].each do |player|
    # p player["first_name"]
    # p player["last_name"]
    # p player["name"]
    # p player["role"]
    # p player["slug"]
    # p player["nationality"]
    # p player["id"]
  end
end

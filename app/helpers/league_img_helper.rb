module LeagueImgHelper

 def league_images(game_acronym)
  image = ['league-card']
  case game_acronym
    when "cs-go"
      image << "league-img-cs"
    when "league-of-legends"
      image << "league-img-lol"
    when "ow"
      image << "league-img-ow"
    when "rl"
      image << "league-img-rl"
    end
    image.join(" ")
  end

end

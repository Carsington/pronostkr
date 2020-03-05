module LogoHelper

 def logo_images(game_acronym)
  image = ""
  case game_acronym
    when "cs-go"
      image << "games/cs-go-logo.png"
    when "league-of-legends"
      image << "games/lol-logo.png"
    when "ow"
      image << "games/overwatch-logo.png"
    when "rl"
      image << "games/rocket-logo.png"
    end
    image
  end

end

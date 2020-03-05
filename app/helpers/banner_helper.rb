module BannerHelper
  def banner_images(game_acronym)
    image = ['competition-banner-img']
    case game_acronym
      when "cs-go"
        image << "cs-go"
      when "league-of-legends"
        image << "lol"
      when "ow"
        image << "overwatch"
      when "rl"
        image << "rocket"
    end
    image.join(" ")
  end
end

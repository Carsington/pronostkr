module BannerHelper
  def banner_images(game_acronym, page)
    image = ['competition-banner-img']
    case game_acronym
      when "cs-go"
        image << "cs-go-#{page}"
      when "league-of-legends"
        image << "lol-#{page}"
      when "ow"
        image << "overwatch-#{page}"
      when "rl"
        image << "rocket-#{page}"
    end
    image.join(" ")
  end
end

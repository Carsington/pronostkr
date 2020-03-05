module BannerHelper
  def banner_image(game_id)
    class_names ['competition-banner-img']
    case game_id == 1
      class_names << "cs-go"
    case game_id == 2
      class_names << "lol"
    case game_id == 3
      class_names << "overwatch"
    case game_id == 4
      class_names << "rocket"
    end
    class_names.join(" ")
  end
end

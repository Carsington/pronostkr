module TeamHelper
  def team_classnames(current_user, match, team)
    class_names = ['team-card']
    forecast = current_user.forecasts.find_by(match: match)
    if forecast && forecast.team.present?
      if forecast.team == team
        class_names << "winning-team"
      else
        class_names << "losing-team"
      end
    end
    class_names.join(" ")
  end
end

class ForecastsController < ApplicationController
  before_action :forecast_values, only: [ :create, :update ]

  def create
    @forecast = current_user.forecasts.build(match: @values[:match], team: @values[:team])

    @forecast.save
    # redirect_to @forecast.competition
  end

  def update
    @forecast = Forecast.find_by(user: current_user, match: @values[:match])

    @forecast.update(forecast_values)
    # redirect_to @forecast.competition
  end

  private

  def forecast_params
    params.require(:forecast).permit(:team, :match)
  end

  def forecast_values
    @values = {
      match: Match.find(params[:forecast][:match]),
      team: Team.find(params[:forecast][:team])
    }
  end
end

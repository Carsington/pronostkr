class ForecastsController < ApplicationController
  before_action :forecast_values, only: [ :create, :update ]

  def create
    @forecast = current_user.forecasts.build(match: @values[:match], team: @values[:team])
    @forecast.save

    respond_to do |format|
      format.html { render 'competitions/show', locals: { competition: @forecast.competition } }
      format.js
    end
  end

  def update
    @forecast = Forecast.find_by(user: current_user, match: @values[:match])
    @forecast.update(forecast_values)

    respond_to do |format|
      format.html { render 'competitions/show', locals: { competition: @forecast.competition } }
      format.js
    end
  end

  private

  def forecast_params
    params.require(:forecast).permit(:team, :match)
  end

  def forecast_values
    @values = {
      match: Match.find(params[:forecast][:match]),
      team: Team.find_by(id: params[:forecast][:team])
    }
  end
end

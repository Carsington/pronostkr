class ForecastsController < ApplicationController
  def new
    @forecast = Forecast.new
  end

  def create
    @forecast = Forecast.new(forecast_params)

    # use find_or_initialize method

    if @forecast.save
      redirect_to @forecast
    end
  end

  private

  def forecast_params
    params.require(:forecast).permit(:user_id, :team_id, :match_id)
  end
end

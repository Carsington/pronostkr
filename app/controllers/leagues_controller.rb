class LeaguesController < ApplicationController

  def show
    @league = League.find(params[:id])
  end

  def create
    @league = League.new(league_params)
    user_league = UserLeague.new(user: current_user, league: @league, is_owner: true)

    if @league.save && user_league.save
      redirect_to @league
    else
      render :new
    end
  end

  def new
    @league = League.new
  end

  private

  def league_params
    params.require(:league).permit(:name, :competition_id)
  end
end

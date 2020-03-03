require 'faker'
class LeaguesController < ApplicationController

  def join_league
   if league = League.find_by(slug: params[:league][:slug].upcase)
     redirect_to league_path(league.id)
   else
    flash.alert = "Cette Ligue n'existe pas :("
    redirect_to dashboard_user_path
    end
  end

  def show
    @league = League.find(params[:id])
    @page_title = "#" + @league.slug
  end

  def create
    slug = Faker::Lorem.unique.characters(number: 6).upcase
    @league = League.new(league_params)
    @league.slug = slug
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
    params.require(:league).permit(:name, :competition_id, :slug)
  end
end

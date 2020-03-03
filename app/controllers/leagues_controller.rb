require 'faker'
class LeaguesController < ApplicationController

  def join_league
    league = League.find_by(slug: params[:league][:slug])
    if league.present?
      participation = UserLeague.new(user: current_user, league: league)
      if participation.save
        flash.notice = "Vous avez rejoint cette ligue"
        return redirect_to league_path(league.id)
      elsif participation.errors.messages.has_key?(:user)
        flash.alert = "Vous appartenez déjà à cette ligue"
      end
    else
      flash.alert = "Cette Ligue n'existe pas :("
    end

    redirect_to request.referrer
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

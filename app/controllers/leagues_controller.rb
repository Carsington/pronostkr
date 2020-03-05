class LeaguesController < ApplicationController

  def join_league
    league = League.find_by(slug: params[:league][:slug].downcase)
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
    @page_title = @league.name
    unless @league.name.start_with?("Gén")
      @page_slug = " - #" + @league.slug
    end
  end

  def create
    slug = generate_slug
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
    @competition_id = params[:competition_id]
  end

  private

  def league_params
    params.require(:league).permit(:name, :competition_id, :slug)
  end

  def generate_slug
    slug = '000000'
    all_slugs = League.all.map { |league| league.slug }
    slug = (0...6).map { (('a'..'z')).to_a[rand(26)] }.join while all_slugs.include? slug 

    return slug
  end
end

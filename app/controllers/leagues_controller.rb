class LeaguesController < ApplicationController

 def create
  @league = League.new(league_params)
  @league.user = current_user

  if @league.save
    redirect_to @league
  else
    render :new
  end
end


def new
  @competition = Competition.find(params[:competition_id])
  @league = League.new
end

private

def league_params
  params.require(:league).permit(:name, :slug)
end

end

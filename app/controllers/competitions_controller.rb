class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @competition = Competition.find(params[:id])
    @page_title = @competition.name
    @live_matches = @competition.matches.live.page(params[:live_page] || 1)
    @upcoming_matches = @competition.matches.upcoming.page(params[:upcoming_page] || 1)
    @finished_matches = @competition.matches.finished.page(params[:finished_page] || 1)
  end
end

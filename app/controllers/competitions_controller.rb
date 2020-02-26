class CompetitionsController < ApplicationController
  def show
    @competition = Competition.find(params[:id])
    @page_title = @competition.name
  end
end

class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @competition = Competition.find(params[:id])
    @page_title = @competition.name
  end
end

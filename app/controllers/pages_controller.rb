class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if params[:query].present? && params[:search][:query].present?
      @query = params[:search][:query]
      @competitions = Competition.search(@query)
    else
      @competitions = Competition.all
    end

    if @competitions.empty?
      @no_results = true
      @competitions = Competition.all
    end
    # @competitions = Competition.all
  end
end

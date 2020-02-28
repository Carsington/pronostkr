class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :sandbox ]

  def home
  end

  def sandbox
    if params[:search].present? && params[:search][:query].present?
      @query = params[:search][:query]
      @competitions = Competition.global_search(@query)
    else
      @competitions = Competition.all
    end

    if @competitions.empty?
      @no_results = true
      @competitions = Competition.all
    end
  end
end

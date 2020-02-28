class UsersController < ApplicationController
  def dashboard
    @page_title = "Tableau de bord"
    @user = current_user

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

  def show
    @user = User.find(params[:id])
  end

  def edit
  end
end

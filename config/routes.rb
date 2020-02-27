Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  # authenticated do
  #   root to: redirect('/dashboard')
  # end

  # unauthenticated do
  #   root to: 'pages#home'
  # end

  get '/dashboard', to: 'users#dashboard', as: :dashboard_user

  resources :users, only: [ :show, :edit ]
  resources :competitions, only: [ :show ]
  resources :leagues, only: [ :show, :new, :create ]
end

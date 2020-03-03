Rails.application.routes.draw do
  devise_for :users

  authenticated do
    root to: redirect('/dashboard')
  end

  unauthenticated do
    root to: 'pages#home'
  end

  get '/dashboard', to: 'users#dashboard', as: :dashboard_user
  get '/sandbox', to: 'pages#sandbox', as: :sandbox
  post '/join_league', to: 'leagues#join_league', as: :join_league


  resources :users, only: [ :show, :edit ]
  resources :competitions, only: [ :show ]
  resources :leagues, only: [ :show, :new, :create ]
  resources :forecasts, only: [ :create, :update ]
end

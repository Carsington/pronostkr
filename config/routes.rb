Rails.application.routes.draw do
  devise_for :users

  authenticated do
    root to: redirect('/dashboard')
  end

  unauthenticated do
    root to: 'pages#home'
  end

  get '/dashboard', to: 'users#dashboard', as: :dashboard_user
  get '/hidden_components', to: 'pages#home', as: :hidden_components

  resources :users, only: [ :show, :edit ]
  resources :competitions, only: [ :show ]
  resources :leagues, only: [ :show, :new, :create ]
end

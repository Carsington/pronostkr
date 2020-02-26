Rails.application.routes.draw do
  devise_for :users

  authenticated do
    root to: 'users#show'
  end

  unauthenticated do
    root to: 'pages#home'
  end

  resources :users, only: [ :show, :edit ]
  resources :competitions, only: [ :show ]
  resources :leagues, only: [ :show, :new, :create ]

end

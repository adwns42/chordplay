Rails.application.routes.draw do
  root to: "home#index"
  resource :home, only: [:index]
  resource :results, only: [:show]
  resources :songs, only: [:show] do
    resource :bookmark, only: [:create, :destroy]
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  resources :users, only: [:show]
end

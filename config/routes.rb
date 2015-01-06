Rails.application.routes.draw do
  root to: "home#index"
  resource :home, only: [:index]
  resource :results, only: [:show]

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }
end

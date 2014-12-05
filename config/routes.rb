Rails.application.routes.draw do
  root to: "home#index"
  resource :home, only: [:index]

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }
end

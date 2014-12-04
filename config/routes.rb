Rails.application.routes.draw do
  resource :home, only: [:index]
  root to: "home#index"

  devise_for :users
end

Rails.application.routes.draw do
  devise_for :users

  root to: "forth#index"
end

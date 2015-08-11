Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations'
  }

  root to: "forth#index"

  get 'about' => 'forth#about'
  get 'privacy' => 'forth#privacy'
  get 'term_condition' => 'forth#term_condition'

  resources :contacts, only: [:new, :create]

  resources :users

  resources :channels do
    resources :streams do
      post :reset_key
    end
  end



end

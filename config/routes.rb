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
    get '/streams/:id/video_upload', to: 'streams#video_upload', as: 'stream_video_upload'
    post '/streams/:id/reset_key', to: 'streams#reset_key', as: 'stream_reset_key'
    resources :streams
  end

  scope 'api', constraints: { format: :json }, defaults: { format: :json }, name_prefix: :api do
    resources :sessions, as: :api_sessions, only: :create do
      collection do
        post :facebook
        post :twitter
      end
    end
    get 'stream_key' => 'streams#check'
  end
end

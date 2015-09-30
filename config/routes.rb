Rails.application.routes.draw do

  get 'subscriptions/index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations'
  }

  root to: "forth#index"

  get 'about' => 'forth#about'
  get 'privacy' => 'forth#privacy'
  get 'term_condition' => 'forth#term_condition'
  get 'search' => 'forth#search'

  resources :contacts, only: [:new, :create]
  resources :users
  resources :subscriptions, only: [:index, :create, :destroy]

  resources :channels, except: [:create, :new] do
    collection do
      get '/:scope', to: 'channels#index', as: :scoped,
          constraints: { scope: /popular|features/ }
    end
    post '/streams/:id/reset_key', to: 'streams#reset_key', as: 'stream_reset_key'
    resources :streams, except: :create do
      collection do
        get '/:scope', to: 'streams#index', as: :scoped,
            constraints: { scope: /upcoming|past/ }
      end
      get '/videos/upload', to: 'videos#upload', as: 'videos_upload'
      resources :videos, only: [:create, :update, :destroy, :show]
    end
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

# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
            path: '',
            # Override default registrations actions to allow name field
            controllers: {
              registrations: 'registrations'
            },
            path_names: {
              sign_in: 'login',
              sign_out: 'logout',
              sign_up: 'signup'
            }

  devise_scope :user do
    # Allow logging out by GET'ing this route (as opposed to POST'ing)
    get '/logout' => 'devise/sessions#destroy'

    authenticated :user do
      root 'welcome#index', as: :authenticated_root
    end
  end

  root 'devise/registrations#new', as: :unauthenticated_root

  get '/welcome' => 'users#new'
  get '/profile' => 'users#index'
  post '/users' => 'users#create'
  put '/users' => 'users#update'

  resources :dashboard, only: [:index]

  resources :plants do
    resources :plantlogs
  end

  resources :water, only: %i[create destroy], controller: 'water_events'

  post '/subscribe' => 'push_notifications#subscribe'
  delete '/unsubscribe' => 'push_notifications#destroy'
  post '/push' => 'push_notifications#create'

  # api
  namespace :api do
    namespace :v1 do
      resources :token, only: %i[index create destroy]
      resources :users, only: %i[index create show update destroy]
      resources :plants, only: %i[index create show update destroy]
    end
  end
end

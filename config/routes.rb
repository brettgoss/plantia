Rails.application.routes.draw do

  devise_for :users,
    # Override default registrations actions to allow name field
    :controllers => { registrations: 'registrations' },
    path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }

  devise_scope :user do
    # Allow logging out by GET'ing this route (as opposed to POST'ing)
    get '/logout' => 'devise/sessions#destroy'

    authenticated :user do
      root 'welcome#index', as: :authenticated_root
    end
  end

  root 'devise/registrations#new', as: :unauthenticated_root

  get '/profile' => 'users#index'
  put '/users/session' => 'users#update_session'

  resources :dashboard, only: [:index]

  resources :plants do
    resources :plantlogs
  end

  resources :water, only: [:create, :destroy], controller: 'water_events'

  post '/subscribe' => 'push_notifications#subscribe'
  delete '/unsubscribe' => 'push_notifications#destroy'
  post '/push' => 'push_notifications#create'

end

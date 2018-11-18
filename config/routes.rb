Rails.application.routes.draw do

  devise_for :users,
    # Override default registrations actions to allow name field
    :controllers => { registrations: 'registrations' }
  devise_scope :user do
    # Allow logging out by getting this route
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'welcome/index'
  root to: 'welcome#index'

  # These routes will be for signup. The first renders a form in the browse, the second will
  # receive the form and create a user in our database using the data given to us by the user.
  get '/welcome' => 'users#new'
  get '/profile' => 'users#index'
  post '/users' => 'users#create'
  put '/users' => 'users#update'

  resources :dashboard, only: [:index]

  resources :plants do
    resources :plantlogs
  end

  resources :water, only: [:create, :destroy], controller: 'water_events'

  post '/subscribe' => 'push_notifications#subscribe'
  delete '/unsubscribe' => 'push_notifications#destroy'
  post '/push' => 'push_notifications#create'

end

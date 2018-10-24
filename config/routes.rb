Rails.application.routes.draw do

  get 'welcome/index'
  root to: 'welcome#index'

  # these routes are for showing users a login form, logging them in, and logging them out.
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # These routes will be for signup. The first renders a form in the browse, the second will
  # receive the form and create a user in our database using the data given to us by the user.
  get '/welcome' => 'users#new'
  get '/me' => 'users#index'
  post '/users' => 'users#create'
  put '/users' => 'users#update'

  resources :dashboard, only: [:index]

  resources :plants do
    resources :plantlogs, only: [:create, :destroy]
  end

  resources :water, only: [:create, :destroy], controller: 'water_events'

  post '/waterall' => 'water_events#water_all'
  post '/subscribe' => 'subscriptions#create'
  delete '/unsubscribe' => 'subscriptions#destroy'
  post '/push' => 'push_notifications#create'

end

Rails.application.routes.draw do

  get 'welcome/index'
  root to: 'welcome#index'

  # these routes are for showing users a login form, logging them in, and logging them out.
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # These routes will be for signup. The first renders a form in the browse, the second will
  # receive the form and create a user in our database using the data given to us by the user.
  get '/' => 'users#new'
  post '/users' => 'users#create'

  resources :dashboard, only: [:index]

  resources :plants do
    resources :water_event, only: [:create, :destroy]
  end

  post '/water' => 'plants#water_event'
end

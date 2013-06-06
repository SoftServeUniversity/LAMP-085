Auth::Application.routes.draw do
  
  # devise_for :users

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  get "log/show"

  get "statistic/show"

  root :to => "reports#index"

  resources :reports
  
  mount Resque::Server, :at => "/resque"
  
end

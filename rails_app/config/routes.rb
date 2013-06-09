Auth::Application.routes.draw do
  
  resources :reports
  get 'reports/:id/system_log' => 'reports#log'

  get 'welcome/index'

  # devise_for :users
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  mount Resque::Server, :at => "/resque"
  
  root :to => "welcome#index"
end

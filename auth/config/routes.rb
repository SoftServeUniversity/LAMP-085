Auth::Application.routes.draw do
  root :to => "reports#index"

  resources :reports


  devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' end
  root :to => 'results#index'

  mount Resque::Server, :at => "/resque"
  
end

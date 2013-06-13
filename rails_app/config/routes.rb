Auth::Application.routes.draw do
  
  resources :reports do 
    collection do 
      get 'system_log' => 'reports#log'
      post 'system_log' => 'reports#download'
    end 
  end

  get 'welcome/index'

  # devise_for :users
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  mount Resque::Server, :at => "/resque"
  
  root :to => "welcome#index"
end

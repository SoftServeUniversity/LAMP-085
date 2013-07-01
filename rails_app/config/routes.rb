Auth::Application.routes.draw do

  resources :reports do
    collection do
      get 'check_homework' => 'reports#check'
    end
  end

  controller :logger do
    get 'logger' => :index
    post 'logger' =>  :load
  end

  controller :statistic do
    get 'statistic' => :index
    get 'statistic/language' => :language
    
  end

  controller :support do
    get 'support/database_restore' => :select
    post 'support/database_restore' => :restore
    get 'support/database_back_up' => :back_up
    get 'support/destroy' => :destroy   
  end

      
  # devise_for :users
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  mount Resque::Server, :at => "/resque"
  
  root :to => "reports#index"
end

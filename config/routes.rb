Upstairs::Application.routes.draw do
  
  resources :involvements, :only => [:new, :create, :destroy]
  resources :roles, :only => [:index, :new, :create, :destroy]
  resources :groups

  resources :users do
    get 'avatar_cropping', :on => :member
  end
  
  resources :sessions, :only => [:new, :create, :destroy]
  
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/auth/:provider/callback', :to => 'sessions#callback'
  match '/auth/failure', :to => 'sessions#failure'
  
  root :to => 'pages#home'
end

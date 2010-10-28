Upstairs::Application.routes.draw do
  
  resources :roles, :only => [:index, :new, :create, :destroy]
  resources :groups

  resources :users
  
  match '/signin', :to => "users#new" 
  
  match '/signup',  :to => 'users#new'
  match '/auth/:provider/callback', :to => 'sessions#create'
  
  root :to => 'users#new'
end

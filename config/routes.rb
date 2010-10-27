Upstairs::Application.routes.draw do
  
  resources :roles
  resources :groups

  resources :users
  
  match '/signup',  :to => 'users#new'
  match '/auth/:provider/callback', :to => 'sessions#create'
  
  root :to => 'users#new'
end

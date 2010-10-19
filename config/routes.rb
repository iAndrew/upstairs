Upstairs::Application.routes.draw do
  resources :users
  
  match '/signup',  :to => 'users#new'
  match '/auth/:provider/callback', :to => 'sessions#create'
  
  root :to => 'users#new'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => "tasks#index"
  
  get '/tasks', to: 'tasks#index', as: 'index'
  
  get '/tasks/new', to: 'tasks#new'
  
  post '/tasks', to: 'tasks#create'
  
  get '/tasks/:id', to: 'tasks#show', as: 'show'
  
end

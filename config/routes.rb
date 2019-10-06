Rails.application.routes.draw do
  
  root 'tasks#index'
  resources :tasks 
  patch '/tasks/:id/completed', to: 'tasks#completed', as: 'completed'
  
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  
  
  
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'

  
end

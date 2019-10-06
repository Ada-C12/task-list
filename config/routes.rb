Rails.application.routes.draw do
  root to: "tasks#index"
  
  resources :tasks
  # get '/tasks', to: 'tasks#index', as: 'index'
  
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  
  # post 'tasks/', to: 'tasks#create', as: 'tasks'
  
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  
  # get '/tasks/new, to: tasks#new'
  
  
  
end
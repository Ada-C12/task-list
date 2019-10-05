Rails.application.routes.draw do
  root :to => "tasks#index"
  
  get '/tasks', to: 'tasks#index', as: 'index'
  
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  
  # get '/tasks/new, to: tasks#new'
  
  
  
end
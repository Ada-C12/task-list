Rails.application.routes.draw do

  root :to => "tasks#index"

  #routes for entire task list 
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'

  #routes for individual tasks 
  get '/tasks/:id', to: 'tasks#show', as: 'task'

end

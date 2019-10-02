Rails.application.routes.draw do

  root :to => "tasks#index"

  #routes for entire task list 
  get '/tasks', to: 'tasks#index', as: 'tasks'



  #routes for individual tasks 
  get '/tasks/:id', to: 'tasks#show', as: 'task'

end

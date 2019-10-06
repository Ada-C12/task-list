Rails.application.routes.draw do

  root :to => "tasks#index"

  # # routes for entire task list 
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'

  # #routes for individual tasks 
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'
  resources :tasks
  patch '/tasks/:id/completed', to: 'tasks#completed', as: 'completed_task'

end

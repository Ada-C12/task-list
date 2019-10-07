Rails.application.routes.draw do
  root to: 'tasks#index'
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  
  resources :tasks
  
  # # Routes that operate on individual tasks
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'

  patch 'tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  patch 'tasks/:id/uncomplete', to: 'tasks#uncomplete', as: 'uncomplete_task' 
  
end

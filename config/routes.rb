Rails.application.routes.draw do
  
  root to: 'tasks#index'
  
  resources :tasks
  
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  
  # get 'tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  
  # patch '/tasks/:id', to: 'tasks#update'
  
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  
  # post '/tasks', to: 'tasks#create'
  
  # delete '/tasks/:id', to: 'tasks#destroy'
  
end

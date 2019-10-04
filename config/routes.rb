Rails.application.routes.draw do
  resources :tasks
  
  root to: 'tasks#index'
  
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  patch '/tasks/:id/not_complete', to: 'tasks#not_complete', as: 'not_complete_task'
  
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'
end

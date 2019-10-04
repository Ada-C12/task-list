Rails.application.routes.draw do
  resources :tasks, except: [:update]
  patch '/tasks/:id', to: 'tasks#update'
  
  root 'tasks#index' 
  patch '/tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_complete'
  
  # I'm going to leave this in here for future reference when studying
  
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'
end

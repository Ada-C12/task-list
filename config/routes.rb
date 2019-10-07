Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Routes that operate on the task collection
  
  # Set the homepage route
  root 'tasks#index'
  
  # resources :tasks #, except: [:index]
  
  #Routes that operate on individual task  
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'
  post '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  
  # Routes that operate on tasks
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id', to: 'tasks#update'
  delete '/tasks/:id', to: 'tasks#destroy'
  
end

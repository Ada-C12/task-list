Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Routes that operate on the book collection
  # Set the homepage route
  
  root 'tasks#index'
  # resources :tasks, except: [:update]
  # patch 'tasks/:id', to: 'tasks#update', as: 'update_task'
  
  get "/tasks", to: "tasks#index", as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'
  
  # Routes that operate on individual books
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id', to: 'tasks#update' 
  delete '/tasks/:id', to: 'tasks#destroy'
  post '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  
end

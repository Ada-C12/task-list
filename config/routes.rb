Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index' #redirects home to index
  
  resources :tasks #Uses built in Rails Routes, Missing Completed
  
  # # Task Collection
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  
  # # Individual Tasks
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'
end

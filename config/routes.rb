Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "tasks#index"
  
  resources :tasks, except: [:update]
  
  # Routes that operate on the task collection
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  
  # Routes that operate on individual tasks
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id', to: 'tasks#update'
  patch '/tasks/:id/complete', to: 'tasks#mark_complete', as: 'mark_complete'
  # delete '/tasks/:id', to: 'tasks#destroy'
  
end

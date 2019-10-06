Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/tasks', to: 'tasks#index', as: 'root_path'


  root 'tasks#index'

  resources :tasks 
  # patch '/tasks/:id', to: 'tasks#update', as: 'update_task'
  patch 'tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'

  

  # root 'tasks#index'
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get 'tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'


  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update', as: 'update_task'
end



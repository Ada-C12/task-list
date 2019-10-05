require 'time'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "tasks#index"

  #All tasks
  #  get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'

  # #Individual tasks
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'
  # patch '/tasks/:id', to 'tasks#toggle_complete', as: 'complete_task'
  # delete '/tasks/:id', to: 'tasks#destroy'

  resources :tasks

end

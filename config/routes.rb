Rails.application.routes.draw do
  resources :tasks
# root 'tasks#index'
# get '/tasks', to: 'tasks#index', as: 'tasks'
# get '/tasks/new', to: 'tasks#new', as: 'new_task'
# get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
# get '/tasks/:id', to: 'tasks#show', as: 'task'
# patch 'tasks/:id', to: 'tasks#update'
# post '/tasks', to: 'tasks#create'
end

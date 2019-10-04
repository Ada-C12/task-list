# config/routes.rb
Rails.application.routes.draw do
  # verb 'path', to: 'controller#action'
  root 'tasks#index'
  resources :tasks
  
  # get '/tasks', to: 'tasks#index'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
end

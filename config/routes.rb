Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'
  get '/tasks', to: 'tasks#index'
  post '/tasks', to: 'tasks#create'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  
  root to: 'tasks#index'
end
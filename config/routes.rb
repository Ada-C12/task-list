Rails.application.routes.draw do
  
  root to: "tasks#index"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # post '/tasks', to: 'tasks#create'
  resources :tasks
end

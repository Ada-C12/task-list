Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => "tasks#index"
  
  get '/tasks', to: 'tasks#index', as: 'tasks'

  get '/tasks/new', to: 'tasks#new', as: 'new_task' 

  post '/tasks', to: 'tasks#create'

  get '/tasks/:id', to: 'tasks#show', as: "task"

  get '/tasks/edit/:id', to: 'tasks#edit', as: 'task_edit'

  post '/tasks/update/:id', to: 'tasks#update', as: 'task_update'


end


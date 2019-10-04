Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/tasks', to: 'tasks#index'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id', to: 'tasks#update', as: 'update_task'
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  
  delete '/tasks/:id', to: 'tasks#delete'
  
  get '/tasks/:id/toggle_complete', to:'tasks#toggle_complete', as: 'task_toggle_complete'
  
  
  # patch '/tasks/:id', to: 'tasks#mark_complete', as: 'mark_complete_task'
  # patch '/tasks/:id', to: 'tasks#un_check', as: 'un_check_task'
  
  root 'tasks#index'
end

# Rails.application.routes.draw do
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   # verb 'path', to: 'controller#action'
#   root to: 'tasks#index'


Rails.application.routes.draw do
  # only generate the specified routes
  root to: 'tasks#index'
  
  patch '/tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as:'complete_task'
  patch '/tasks/:id/toggle_incomplete', to: 'tasks#toggle_incomplete', as:'incomplete_task'
  
  resources :tasks 
  
  
end


# get '/tasks', to: 'tasks#index', as: "tasks"
# get '/tasks/new', to: 'tasks#new', as: 'new_task'
# post '/tasks', to: 'tasks#create'

# get '/tasks/:id', to: 'tasks#show', as: 'task'
# get '/tasks/:id/edit', to: 'tasks#edit', as:'edit_task'
# patch '/tasks/:id', to: 'tasks#update'
# delete '/tasks/:id', to: 'tasks#destroy'

# patch '/tasks/:id/complete', to: 'tasks#toggle_complete', as:'complete_task'

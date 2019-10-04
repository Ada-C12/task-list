Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
  # The following is included in resources
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'
  
  root 'tasks#index', as: 'root'
  patch '/tasks/:id/completed', to: 'tasks#make_completed', as: 'completed_task'
  patch '/tasks/:id/not_completed', to: 'tasks#make_not_completed', as: 'not_completed_task'
end


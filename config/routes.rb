Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # verb 'path', to: 'controller#action'
    
   # Routes that operate on all tasks
    root 'tasks#index'
    get '/tasks', to: 'tasks#index', as: 'tasks'
    get '/tasks/new', to: 'tasks#new', as: 'new_task'
    post '/tasks', to: 'tasks#create'
  
     # Routes that operate on individual tasks
    get '/tasks/:id', to: 'tasks#show', as: 'task'
    get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
    patch '/tasks/:id', to: 'tasks#update', as: 'update_task'
    delete '/tasks/:id', to: 'tasks#destroy'
  
end



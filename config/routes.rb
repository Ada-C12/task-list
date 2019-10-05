Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Routes that operate on the task collection
  #set the homepage route
  root 'tasks#index'
  #resources :tasks, only: [:index, :show]
  #also can use as resources :tasks, except: :index

  resources :tasks #covered all the lines below:

  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # post '/tasks', to: 'tasks#create'

  # # Routes that operate on individual tasks
  #   #get '/tasks/:id', to: 'tasks#show', as: 'task'
  #   get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  #   patch '/tasks/:id', to: 'tasks#update'
  #   delete '/tasks/:id', to: 'tasks#destroy'

  # Change this to a better path if you think of a better one
  patch '/tasks/:id/complete', to: 'tasks#toggle_complete', as: 'completed'
  
  
end

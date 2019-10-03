Rails.application.routes.draw do
  root to: 'tasks#index'
  
  get '/tasks', to: 'tasks#index'
  
  # I think normall resources :tasks will take care of all the routes for me...?
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'
  
  
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end




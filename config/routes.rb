Rails.application.routes.draw do
  
  root to: 'tasks#index'
  
  get '/tasks', to: 'tasks#index'
  
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  
end
